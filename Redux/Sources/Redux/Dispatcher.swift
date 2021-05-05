/// This protocol represent an ability to dispatch different things to redux store.
public protocol Dispatcher {
    associatedtype Action
    func dispatch(action: Action)
}

/// Example of disptach extension
extension Dispatcher {
    public func dispatch(actions: [Action]) {
        actions.forEach(dispatch(action:))
    }
    
    public func dispatch(action: Action?) {
        guard let action = action else { return }
        dispatch(action: action)
    }
}
