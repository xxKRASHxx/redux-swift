import Swinject
import SwinjectAutoregistration
import Redux
import AppStore

public final class StoreAssembly: Assembly {
    public func assemble(container: Container) {
        container
            .autoregister(AppStore.Main.self, initializer: AppStore.Main.default)
            .inObjectScope(.container)
    }
}
