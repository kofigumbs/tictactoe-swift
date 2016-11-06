public protocol Sheet {
    var size: Int { get }
    var x: [String] { get }
    var o: [String] { get }
    var empty: [String] { get }
    var vertical: [String] { get }
    var horizontal: [String] { get }
    var junction: [String] { get }
}
