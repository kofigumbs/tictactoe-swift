public protocol UserInterface {

    associatedtype Mark: Hashable

    func prompt(board: Board<Mark>, move: @escaping (Int) -> Void)

    func end(board: Board<Mark>)

}
