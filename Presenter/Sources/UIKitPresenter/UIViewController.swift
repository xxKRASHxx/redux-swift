#if !os(macOS)

import UIKit
import Presenter
import Redux

open class ViewControllerPresenter<ViewController: UIViewController & Renderer>: UIViewController, Presenter {
    
    public typealias R = ViewController
        
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(_ builder: () -> ViewController) {
        self.init()
        present(builder())
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func present(_ renderer: ViewController) {
        renderer.willMove(toParent: self)
        addChild(renderer)
        view.addSubview(renderer.view)
        renderer.didMove(toParent: self)
    }
}

#endif
