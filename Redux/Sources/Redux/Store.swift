import Foundation

open class Store<State, Action> {
    
    private(set) public var state: State
    
    private let reducer: Reducer<State, Action>
    private let chain: Middleware<State, Action>
    private var observers: Set<Observer> = []
    
    private let queue: DispatchQueue
    
    public init(
        state: State,
        reducer: @escaping Reducer<State, Action>,
        middleware chain: CompositeMiddleware<State, Action>,
        queue: DispatchQueue = .init(label: "com.redux.store")
    ) {
        self.state = state
        self.reducer = reducer
        self.queue = queue
        self.chain = chain.middleware
    }
}

extension Store {
    public func addObserver(
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
            self.chain( { self.state }, action, { next in
                self.state = self.reducer(self.state, next)
            })
            self.observers.forEach { $0.handleState(self.state) }
        }
    }
}
