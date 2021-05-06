public typealias Middleware<State, Action> = (
    () -> State,
    Action,
    (Action) -> ()
) -> ()

public protocol MiddlewareProtocol {
    associatedtype State
    associatedtype Action

    var middleware: Middleware<State, Action> { get }
}

public struct CompositeMiddleware<State, Action>: MiddlewareProtocol {
    
    public let middleware: Middleware<State, Action>
    
    public init<M: MiddlewareProtocol>(_ middlewares: M...)
    where M.State == State, M.Action == Action {
        let initial: Middleware<State, Action> = { store, action, next in next(action) }
        middleware = middlewares
            .map { $0.middleware }
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


