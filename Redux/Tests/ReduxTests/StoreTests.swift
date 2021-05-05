import Quick
import Nimble

@testable import Redux

class ReduxSpec: QuickSpec {
    
    enum Action {
        case increment, decrement
    }
    
    var store: Store<Int, Action>!
    
    
    override func spec() {
        
        describe("Reducer") {
            
            let reducer: Reducer<Int, Action> = { (state, action) in
                switch action {
                case .increment: return state.advanced(by: 1);
                case .decrement: return state.advanced(by: -1);
                }
            }
            
            beforeEach {
                self.store = Store<Int, Action>(
                    state: 0,
                    reducer: reducer
                )
            }
            
            context("When dispatch some action") {
                
                it("Should get called initially") {
                    _ = self.store.addObserver { state in
                        expect(state).to(equal(0))
                    }
                }
                
                it("Should get called after dispatch") {
                    var callCount = 0;
                    
                    _ = self.store.addObserver { state in
                        callCount = callCount.advanced(by: 1)
                    }
                    
                    self.store.dispatch(action: .increment)
                    self.store.dispatch(action: .decrement)
                    
                    expect(callCount).toEventually(equal(3))
                }
            }
        }
        
        describe("Middleware") {
            
            let reducer: Reducer<Int, Action> = { (state, action) in
                switch action {
                case .increment: return state.advanced(by: 1);
                case .decrement: return state.advanced(by: -1);
                }
            }
            
            let middleware: Middleware<Int, Action> = { store, action, next in
                print("Middleware 1: \(action)")
                next(action);
                next(action);
            }
            
            let middleware2: Middleware<Int, Action> = { store, action, next in
                print("Middleware 2: \(action)")
                next(action);
            }
            
            beforeEach {
                self.store = Store<Int, Action>(
                    state: 0,
                    reducer: reducer,
                    middlewares: [middleware, middleware2]
                )
            }
            
            context("Execution order") {
                
                it("Should get called BEFORE reducer") {
                    self.store.dispatch(action: .increment)
                    
                    //TODO:
                }
                
//                it("Should have correct state") {
//                    self.store.dispatch(action: .increment)
//                    
//                    _ = self.store.addObserver { state in
//                        expect(state).to(equal(2))
//                    }
//                }
            }
        }
    }
}
