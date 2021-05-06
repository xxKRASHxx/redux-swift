import Redux

typealias AppReducer = Reducer<AppState, AppAction>

private let incrementReducer: AppReducer = TypedReducer { (state, action: IncrementAction) in
    .init(counter: state.counter.advanced(by: 1))
}.reduce


private let decrementReducer: AppReducer = TypedReducer { (state, action: DecrementAction) in
    .init(counter: state.counter.advanced(by: -1))
}.reduce


private let counterReducer: AppReducer = CompositeReducer(
    incrementReducer,
    decrementReducer
).reduce

let appReducer: AppReducer = CompositeReducer<AppState, AppAction>(
    counterReducer
).reduce
