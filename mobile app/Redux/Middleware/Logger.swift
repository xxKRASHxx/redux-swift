import Redux

// MARK: - Implementation

struct Logger: MiddlewareProtocol {
    
    let identifier: String
    
    init(identifier: String = "Logger") {
        self.identifier = identifier
    }
    
    var middleware: Middleware<AppState, AppAction> {
        { store, action, next in
            print("\(identifier): \(action)")
            next(action)
        }
    }
}

struct Double: MiddlewareProtocol {
    var middleware: Middleware<AppState, AppAction> {
        { store, action, next in
            print("Double: \(action)")
            next(action)
            next(action)
        }
    }
}

// MARK: - Create middleware instance

let genericLogger = GenericMiddleware<AppState, AppAction> { getState, action, next in
    print("Generic logger: \(action)")
    next(action)
}

let customLogger = Logger()

let double = Double()

let typedIncrement = TypedMiddleware<AppState, AppAction>(to: IncrementAction.self) { getState, action, next in
    print("Typed: \(type(of: action))")
    next(action)
}

let typedDecrementMiddleware: Middleware<AppState, AppAction> = TypedMiddleware(
    to: DecrementAction.self
) { getState, action, next in
    print("Typed: \(type(of: action))")
    next(action)
}.middleware

// MARK: - Composite result

let logger = CompositeMiddleware<AppState, AppAction>(
    Double().middleware,
    double.middleware,
    typedIncrement.middleware,
    typedDecrementMiddleware,
    customLogger.middleware,
    genericLogger.middleware
)
