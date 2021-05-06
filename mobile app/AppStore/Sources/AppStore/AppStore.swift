import Redux

public final class Main: Store<AppState, AppAction> {
    public static func `default`() -> Main {
        .init(
            state: AppState(counter: 0),
            reducer: appReducer,
            middleware: .init(
                logger.middleware
            )
        )
    }
}
