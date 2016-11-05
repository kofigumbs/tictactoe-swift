public protocol UserInterface {

    associatedtype Mark: Hashable

    func prompt(on board: Board<Mark>, move: @escaping (Int) -> Void)

}