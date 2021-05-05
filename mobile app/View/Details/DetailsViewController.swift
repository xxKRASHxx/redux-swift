import UIKit
import Presenter

extension Details {
    enum Props {}
}

extension Details {
    final class ViewController: UIViewController {
        override func loadView() {
            super.loadView()
            
            view.backgroundColor = .white
            let label = UILabel()
            label.text = "This is details"
            label.textAlignment = .center
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

extension Details.ViewController: Renderer {
    func render(props: Details.Props) {
        print("try to call me ;)")
    }
}
