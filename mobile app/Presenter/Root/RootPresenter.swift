import UIKit
import UIKitPresenter
import Redux
import Presenter

extension Root {
    
    final class Presenter<ViewController: UIViewController & Renderer>:
        AppPresenter<ViewController> where ViewController.Props == Root.Props {
        
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
        
        override func map(state: AppState) -> Props? {
            .init(
                counter: state.counter,
                increment: { [weak store] in store?.dispatch(action: IncrementAction()) },
                details: { [weak navigator] in navigator?.navigate(to: .details) }
            )
        }
    }
}
