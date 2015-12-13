struct Game<T: Hashable> {

    let board: Board<T>

    func isOver() -> Bool {
        return board.isFull || winner() != nil
    }

    func winner() -> T? {
        return gatherWinningCombos().map({ $0.0 }).first
    }

    private func gatherWinningCombos() -> [(T, [Int])] {
        return groupIndicies().filter({ hasWinningCombo($0.1) })
    }

    private func groupIndicies() -> [T: [Int]] {
        return board.enumerate().reduce(Dictionary<T, [Int]>(), combine: groupIndex)
    }

    private func groupIndex(var acc: [T: [Int]], entry: (Int, T?)) -> [T: [Int]] {
        let (index, value) = entry
        if let mark = value { acc[mark] = (acc[mark] ?? []) + [index] }
        return acc
    }

    private func hasWinningCombo(marks: [Int]) -> Bool {
        let subsetOfMarks = { (indicies: [Int]) in Set(indicies).isSubsetOf(marks) }
        return indiciesForRows(board.dimmension).contains(subsetOfMarks) ||
            indiciesForColumns(board.dimmension).contains(subsetOfMarks) ||
            indiciesForDiagonals(board.dimmension).contains(subsetOfMarks)
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
