import Redux

struct Logger: MiddlewareProtocol {
    
     var middleware: Middleware<AppState, AppAction> = { store, action, next in
        print(action)
        next(action)
    }
}

let loggerMiddleware = CompositeMiddleware(
    Logger(),
    Logger()
)
