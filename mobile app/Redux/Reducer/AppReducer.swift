import Redux

let appReducer: Reducer<AppState, AppActions> = { (state, action) in
    switch action {
    case .increment: return .init(counter: state.counter.advanced(by: 1));
    case .decrement: return .init(counter: state.counter.advanced(by: -1));
    }
}
