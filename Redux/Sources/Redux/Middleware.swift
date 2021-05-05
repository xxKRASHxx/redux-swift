

public typealias Middleware<State, Action> = (
    Store<State, Action>,
    Action,
    (Action) -> ()
) -> ()
