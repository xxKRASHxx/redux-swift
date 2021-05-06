import Redux

typealias CounterReducer = Reducer<Int, AppAction>

private let incrementReducer: CounterReducer
    = TypedReducer { (state, _: IncrementAction) in state.advanced(by: 1) }.reduce

private let decrementReducer: CounterReducer
    = TypedReducer { (state, _: DecrementAction) in state.advanced(by: -1) }.reduce

let counterReducer: CounterReducer = CompositeReducer(
    incrementReducer,
    decrementReducer
).reduce
