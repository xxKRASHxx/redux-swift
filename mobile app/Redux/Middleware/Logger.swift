import Redux

let logger: Middleware<AppState, AppActions> = { store, action, next in
    print(action)
    next(action)
}
