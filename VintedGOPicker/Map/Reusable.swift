public protocol Reusable {}

extension Reusable {
    public var reuseIdentifier: String {
        "\(type(of: self))"
    }
    public static var reuseIdentifier: String {
        "\(type(of: self))"
    }
}
