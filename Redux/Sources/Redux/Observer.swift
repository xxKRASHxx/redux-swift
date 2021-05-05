import Foundation

public extension Store.Observer {
    enum Mode {
        case every
        case throttle
    }
}

extension Store {
    public class Observer {
        
        let handleState: (State?) -> ()
        
        init(
            queue: DispatchQueue,
            mode: Mode,
            observer: @escaping (State) -> ()
        ) {
            switch mode {
            case .throttle:
                handleState = Observer.throttlingHandler(
                    for: queue,
                    callback: observer)
                
            case .every:
                handleState = Observer.everyUpdateHandler(
                    for: queue,
                    callback: observer)
            }
        }
    }
}

extension Store.Observer {
    static func throttlingHandler(
        for queue: DispatchQueue,
        callback: @escaping (State) -> ()
    ) -> (State?) -> () {
        /// Queue for protecting access to pending props
        let observerQueue = DispatchQueue(label: "com.redux.observer")
        
        /// Intermediate storage for props
        var pendingState: State?
        
        return { state in
            queue.sync {
                let isRunningCallbackNeeded = pendingState == nil && state != nil
                pendingState = state
                guard isRunningCallbackNeeded else { return }
                
                observerQueue.async {
                    var state: State?
                    queue.sync {
                        state = pendingState
                        pendingState = nil
                    }
                    if let state = state {
                        callback(state)
                    }
                }
            }
        }
    }
    
    static func everyUpdateHandler(
        for queue: DispatchQueue,
        callback: @escaping (State) -> ()
    ) -> (State?) -> () {
        return { state in
            guard let state = state else { return }
            queue.async {
                callback(state)
            }
        }
    }
}

extension Store.Observer: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
    public static func == (left: Store.Observer, right: Store.Observer) -> Bool {
        return left === right
    }
}
