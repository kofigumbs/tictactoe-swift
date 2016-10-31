public protocol Player {

    associatedtype Mark: Hashable

    var team: Mark { get }

    func evaluate(board: Board<Mark>) -> Int

}
