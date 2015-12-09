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
    var groupedIndicies = Dictionary<T, [Int]>()
    for (index, value) in grid.enumerate() {
        if let mark = value {
            groupedIndicies[mark] = (groupedIndicies[mark] ?? []) + [index]
        }
    }
    return groupedIndicies
}

private func hasWinningCombo(dimmension: Int, marks: [Int]) -> Bool {
    let marksAsSubset = { marks == $0 }
    return indiciesForRows(dimmension).contains(marksAsSubset) ||
        indiciesForColumns(dimmension).contains(marksAsSubset) ||
        indiciesForDiagonals(dimmension).contains(marksAsSubset)
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
