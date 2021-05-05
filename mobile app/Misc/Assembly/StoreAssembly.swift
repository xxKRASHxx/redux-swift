import Swinject
import SwinjectAutoregistration
import Redux

public final class StoreAssembly: Assembly {
    public func assemble(container: Container) {
        container
            .autoregister(AppStore.self, initializer: AppStore.default)
            .inObjectScope(.container)
    }
}
