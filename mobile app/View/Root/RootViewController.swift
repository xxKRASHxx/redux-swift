import UIKit
import SnapKit
import Presenter

extension Root {
    struct Props {
        let counter: Int
        let increment: () -> Void
        let details: () -> Void
    }
}

extension Root {
    final class ViewController: UIViewController {
        
        var props: Props? {
            didSet {
                guard isViewLoaded else { return }
                view.setNeedsLayout()
            }
        }
        
        private lazy var detailsButton = UIButton(type: .system)
        private lazy var incrementButton = UIButton(type: .system)
        private lazy var counterLabel = UILabel()
        private lazy var stackView = UIStackView()
        
        override func loadView() {
            super.loadView()
            [counterLabel, detailsButton, incrementButton]
                .forEach(stackView.addArrangedSubview)
            view.addSubview(stackView)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupLayout()
            setupStyle()
            setupObserving()
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            counterLabel.text = props?.counter.description
        }
        
        @objc func detailsButtonTouched(sender: UIButton) {
            props?.details()
        }
        
        @objc func incrementButtonTouched(sender: UIButton) {
            props?.increment()
        }
    }
}
private typealias Setup = Root.ViewController
private extension Setup {
    func setupObserving() {
        detailsButton.addTarget(
            self,
            action: #selector(detailsButtonTouched(sender:)),
            for: .touchUpInside)
        incrementButton.addTarget(
            self,
            action: #selector(incrementButtonTouched(sender:)),
            for: .touchUpInside)
    }
    
    func setupStyle() {
        stackView.axis = .vertical
        view.backgroundColor = .white
        counterLabel.textAlignment = .center
        detailsButton.setTitle("Details", for: .normal)
        incrementButton.setTitle("Increment", for: .normal)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension Root.ViewController: Renderer {
    func render(props: Root.Props) {
        self.props = props
    }
}
