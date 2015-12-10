import UI

func gameIsOver<T: Hashable>(grid: Grid<T>) -> Bool {
    return isBoardFull(grid) || teamHasWon(grid)
}

func winnerOf<T: Hashable>(board: Grid<T>) -> T? {
    return gatherWinningCombos(board).first.map({ $0.0 })
}

private func teamHasWon<T: Hashable>(grid: Grid<T>) -> Bool {
    return !gatherWinningCombos(grid).isEmpty
}

private func gatherWinningCombos<T: Hashable>(grid: Grid<T>) -> [(T, [Int])] {
    return groupIndicies(grid)
        .filter({ hasWinningCombo(grid.dimmension, marks: $0.1) })
}

private func groupIndicies<T: Hashable>(grid: Grid<T>) -> [T: [Int]] {
    return grid.enumerate().reduce(Dictionary<T, [Int]>(), combine: groupIndex)
}

private func groupIndex<T: Hashable>(var acc: [T: [Int]], entry: (Int, T?)) -> [T: [Int]] {
    let (index, value) = entry
    _ = value.map({ acc[$0] = (acc[$0] ?? []) + [index] })
    return acc
}

private func hasWinningCombo(dimmension: Int, marks: [Int]) -> Bool {
    let subsetOfMarks = { (indicies: [Int]) in Set(indicies).isSubsetOf(marks) }
    return indiciesForRows(dimmension).contains(subsetOfMarks) ||
        indiciesForColumns(dimmension).contains(subsetOfMarks) ||
        indiciesForDiagonals(dimmension).contains(subsetOfMarks)
}

private func indiciesForRows(dimmension: Int) -> [[Int]] {
    return (0 ..< dimmension)
        .map({ (i) in (0 ..< dimmension).map({ (j) in i + j }) })
}

private func indiciesForColumns(dimmension: Int) -> [[Int]] {
    return (0 ..< dimmension)
        .map({ (i) in (0 ..< dimmension).map({ (j) in i + j * dimmension }) })
}

private func indiciesForDiagonals(dimmension: Int) -> [[Int]] {
    let rightDiagonal = (0 ..< dimmension).map({ (dimmension + 1) * $0 })
    let leftDiagonal = (0 ..< dimmension).map({ (dimmension - 1) * ($0 + 1) })
    return [rightDiagonal, leftDiagonal]
}
