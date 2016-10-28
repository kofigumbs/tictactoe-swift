public protocol Window {

    associatedtype Mark: Hashable

    func promptUserForIndex() -> Int

    func draw(board: Board<Mark>)

}
