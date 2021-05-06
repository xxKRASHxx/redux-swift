public typealias Reducer<State, Action> = (State, Action) -> State

public protocol ReducerProtocol {
    associatedtype Action
    associatedtype State
    
    var reduce: Reducer<State, Action> { get }
}

public struct CompositeReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init(_ reducers: Reducer<State, Action>...) {
        self.reduce = { state, action in
            reducers.reduce(state) { (state, reducer) in reducer(state, action) }
        }
    }
}

public struct TypedReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init<A>(_ reducer: @escaping Reducer<State, A>) {
        self.reduce = { state, action in
            switch action {
            case let action as A:
                return reducer(state, action)
            default:
                return state
            }
        }
    }
}

public struct PartialReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init<T>(of key: WritableKeyPath<State, T>, _ reduce: @escaping Reducer<T, Action>) {
        self.reduce = { state, action in
            var state = state
            state[keyPath: key] = reduce(state[keyPath: key], action)
            return state
        }
    }
}
