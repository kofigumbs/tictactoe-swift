import UI

func gameIsOver<T: Hashable>(grid: Grid<T>) -> Bool {
    return isBoardFull(grid) || teamHasWon(grid)
}

private func teamHasWon<T: Hashable>(grid: Grid<T>) -> Bool {
    let winningCombos = groupIndicies(grid)
        .values.filter({ hasWinningCombo(grid.dimmension, marks: $0) })
    return !winningCombos.isEmpty
}

private func groupIndicies<T: Hashable>(grid: Grid<T>) -> [T: [Int]] {
    return grid.enumerate().reduce(Dictionary<T, [Int]>(), combine: { (var acc, cell) in
        if let mark = cell.1 {
            acc[mark] = (acc[mark] ?? []) + [cell.0]
        }
        return acc
    })
}

private func hasWinningCombo(dimmension: Int, marks: [Int]) -> Bool {
    let marksAsSuperset = { (indicies: [Int]) in Set(marks).isSupersetOf(indicies) }
    return indiciesForRows(dimmension).contains(marksAsSuperset) ||
        indiciesForColumns(dimmension).contains(marksAsSuperset) ||
        indiciesForDiagonals(dimmension).contains(marksAsSuperset)
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
