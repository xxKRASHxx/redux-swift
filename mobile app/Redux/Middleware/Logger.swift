import Redux

// MARK: - Implementation

struct Logger: MiddlewareProtocol {
    
    let identifier: String
    
    init(identifier: String = "") {
        self.identifier = identifier
    }
    
    var middleware: Middleware<AppState, AppAction> {
        { store, action, next in
            print(identifier + ": \(action)")
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

let typedIncrementMiddleware = TypedMiddleware<AppState, AppAction>(to: IncrementAction.self) { getState, action, next in
    print("Increment!")
    next(action)
}

let typedDecrementMiddleware = TypedMiddleware<AppState, AppAction>(to: DecrementAction.self) { getState, action, next in
    print("Decrement!")
    next(action)
}

// MARK: - Composite result

let logger = CompositeMiddleware<AppState, AppAction>(
    Double().middleware,
    double.middleware,
    typedIncrementMiddleware.middleware,
    typedDecrementMiddleware.middleware,
    customLogger.middleware,
    genericLogger.middleware
)
