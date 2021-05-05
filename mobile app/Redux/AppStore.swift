import Redux

final class AppStore: Store<AppState, AppActions> {
    static func `default`() -> AppStore {
        .init(
            state: AppState(counter: 0),
            reducer: appReducer,
            middlewares: [
                logger
            ]
        )
    }
}