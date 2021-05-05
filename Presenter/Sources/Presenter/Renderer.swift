public protocol Renderer {
    associatedtype Props
    func render(props: Props)
}
