import Redux

let appReducer: Reducer<AppState, AppAction> = { (state, action) in
    switch action {
    case is IncrementAction: return .init(counter: state.counter.advanced(by: 1));
    case is DecrementAction: return .init(counter: state.counter.advanced(by: -1));
    default: return state
    }
}
