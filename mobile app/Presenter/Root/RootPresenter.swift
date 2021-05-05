import UIKit
import UIKitPresenter
import Redux

extension Root {
    final class Presenter: AppPresenter<ViewController> {
        
        private let navigator: Navigator
        
        init(
            navigator: Navigator = .init(),
            renderer: ViewController
        ) {
            self.navigator = navigator
            super.init()
            navigator.base = self
            present(renderer)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func present(_ renderer: ViewController) {
            super.present(renderer)
            
            weak var wRenderer = renderer
            weak var wStore = store
            weak var wNavigator = navigator
            
            _ = store.addObserver { state in
                DispatchQueue.main.async {
                    wRenderer?.render(props: .init(
                        counter: state.counter,
                        increment: { wStore?.dispatch(action: .increment) },
                        details: { wNavigator?.navigate(to: .details) }
                    ))
                }
            }
        }
    }
}
