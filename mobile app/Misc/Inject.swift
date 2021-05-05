import Swinject

public extension Container {
    static let `default` = Container()
}

@propertyWrapper
public final class Inject<Service> {

    private lazy var component: Service = resolver.resolve(Service.self, name: name)!
    private let resolver: Resolver
    private let name: String?

    public init(_ resolver: Resolver = Container.default, name: String? = nil) {
        self.resolver = resolver
        self.name = name
    }

    public var wrappedValue: Service {
        get { component }
    }
}
