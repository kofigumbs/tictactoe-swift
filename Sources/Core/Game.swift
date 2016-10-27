struct Game<T: Hashable> {

    let board: Board<T>

    func isOver() -> Bool {
        return board.isFull || winner() != nil
    }

    func winner() -> T? {
        return gatherWinningCombos().map({ $0.0 }).first
    }

    private func gatherWinningCombos() -> [(T, [Int])] {
        return groupIndicies().filter({ hasWinningCombo(marks: $0.1) })
    }

    private func groupIndicies() -> [T: [Int]] {
        return board.enumerated().reduce([T: [Int]](), groupIndex)
    }

    private func groupIndex(acc: [T: [Int]], entry: (Int, T?)) -> [T: [Int]] {
        var acc = acc
        let (index, value) = entry

        if let mark = value { acc[mark] = (acc[mark] ?? []) + [index] }

        return acc
    }

    private func hasWinningCombo(marks: [Int]) -> Bool {
        let subsetOfMarks = { (indicies: [Int]) in Set(indicies).isSubset(of: Set(marks)) }
        return indiciesForRows(dimmension: board.dimmension).contains(where: subsetOfMarks) ||
            indiciesForColumns(dimmension: board.dimmension).contains(where: subsetOfMarks) ||
            indiciesForDiagonals(dimmension: board.dimmension).contains(where: subsetOfMarks)
    }

    private func indiciesForRows(dimmension: Int) -> [[Int]] {
        return (0 ..< dimmension)
            .map({ i in (0 ..< dimmension).map({ j in i * dimmension + j }) })
    }

    private func indiciesForColumns(dimmension: Int) -> [[Int]] {
        return (0 ..< dimmension)
            .map({ i in (0 ..< dimmension).map({ j in i + j * dimmension }) })
    }

    private func indiciesForDiagonals(dimmension: Int) -> [[Int]] {
        let rightDiagonal = (0 ..< dimmension).map({ (dimmension + 1) * $0 })
        let leftDiagonal = (0 ..< dimmension).map({ (dimmension - 1) * ($0 + 1) })
        return [rightDiagonal, leftDiagonal]
    }
}
