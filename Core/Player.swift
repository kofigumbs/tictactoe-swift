protocol Player {

    typealias T: Hashable

    var team: T { get }

    func evaluate(board: Board<T>) -> Int

}

