import Redux

typealias AppReducer = Reducer<AppState, AppAction>

private let counter = PartialReducer<AppState, AppAction>(of: \.counter, counterReducer)

let appReducer: AppReducer = CompositeReducer<AppState, AppAction>(
    counter.reduce
).reduce


