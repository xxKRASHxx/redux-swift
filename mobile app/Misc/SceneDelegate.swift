import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("\(scene) must be type of UIWindowScene")
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = Root.Presenter(
            renderer: Root.ViewController()
        )
        window?.makeKeyAndVisible()
    }
}

