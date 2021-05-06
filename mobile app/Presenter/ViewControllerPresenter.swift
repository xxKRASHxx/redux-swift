import UIKit
import UIKitPresenter
import Presenter
import Redux
import AppStore

class AppPresenter<ViewController: UIViewController & Renderer>:
    ViewControllerPresenter<ViewController> {
    @Inject var store: AppStore.Main
    
    override func present(_ renderer: ViewController) {
        super.present(renderer)
        _ = store.addObserver { [weak self, weak renderer] (state) in
            DispatchQueue.main.async {
                guard
                    let self = self,
                    let props = self.map(state: state)
                else { return }
                renderer?.render(props: props)
            }
        }
    }
    
    func map(state: AppState) -> ViewController.Props? {
        nil
    }
}
