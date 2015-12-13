protocol Player {

    typealias T: Hashable
    func evaluate(board: Board<T>) -> Int

}

