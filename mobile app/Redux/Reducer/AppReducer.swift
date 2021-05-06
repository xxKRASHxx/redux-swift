import Redux

typealias AppReducer = Reducer<AppState, AppAction>

let incrementReducer: AppReducer = TypedReducer { (state, action: IncrementAction) in
    .init(counter: state.counter.advanced(by: 1))
}.reduce


let decrementReducer: AppReducer = TypedReducer { (state, action: DecrementAction) in
    .init(counter: state.counter.advanced(by: -1))
}.reduce


let counterReducer: AppReducer = CompositeReducer(
    incrementReducer,
    decrementReducer
).reduce

let appReducer: AppReducer = CompositeReducer<AppState, AppAction>(
    counterReducer
).reduce
