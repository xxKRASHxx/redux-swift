import UIKit
import UIKitPresenter
import Presenter
import Redux

class AppPresenter<ViewController: UIViewController & Renderer>:
    ViewControllerPresenter<ViewController> {
    @Inject var store: AppStore
}
