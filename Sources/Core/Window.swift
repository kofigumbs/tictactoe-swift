public protocol Window {

    associatedtype T: Hashable

    func promptUserForIndex() -> Int

    func draw(board: Board<T>)

}
