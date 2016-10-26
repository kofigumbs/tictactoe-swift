public protocol Player {

    associatedtype T: Hashable

    var team: T { get }

    func evaluate(board: Board<T>) -> Int

}

