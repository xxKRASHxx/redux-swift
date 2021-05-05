import Foundation

public class Store<State, Action> {
    
    private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private let chain: Middleware<State, Action>
    private var observers: Set<Observer> = []
    
    private let queue: DispatchQueue
    
    public init(
        state: State,
        reducer: @escaping Reducer<State, Action>,
        middlewares: [Middleware<State, Action>] = [],
        queue: DispatchQueue = .init(label: "com.redux.store")
    ) {
        self.state = state
        self.reducer = reducer
        self.queue = queue
        
        let initial: Middleware<State, Action> = { store, action, next in
            next(action);
        }
        
        self.chain = middlewares
            .reversed()
            .reduce(initial) { result, middleware in
                { store, action, next in
                    middleware(store, action) { action in
                        result(store, action, next)
                    }
                }
            }
    }
}

extension Store {
    func addObserver(
        on queue: DispatchQueue = .main,
        mode: Observer.Mode = .throttle,
        callback: @escaping (State) -> ()
    ) -> () -> () {
        
        let observer = Observer(
            queue: queue,
            mode: mode,
            observer: callback
        )
         
         self.queue.async {
             self.observers.insert(observer)
             observer.handleState(self.state)
         }
         
         return {
             self.queue.async {
                 self.observers.remove(observer)
                 observer.handleState(nil)
             }
         }
     }
}

extension Store: Dispatcher {
    public func dispatch(action: Action) {
        queue.async {
            
            self.chain(self, action, { action in
                self.state = self.reducer(self.state, action)
            })
            
            self.observers.forEach { $0.handleState(self.state) }
        }
    }
}
