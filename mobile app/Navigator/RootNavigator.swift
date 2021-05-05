import UIKit

extension Root {
    final class Navigator: mobile_app.Navigator {
        
        enum Destination {
            case details
        }
        
        weak var base: UIViewController? = nil
        
        func navigate(to destination: Destination) {
            
            guard base != nil else {
               return assertionFailure("base view is not set for \(self).")
            }
            
            switch destination {
            case .details:
                base?.present(
                    Details.Presenter(
                        Details.ViewController()
                    ),
                    animated: true,
                    completion: nil
                )
            }
        }
    }
}
