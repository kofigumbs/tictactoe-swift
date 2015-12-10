import UI

func markBoard<T>(grid: Grid<T>, position: Int, team: T) -> Grid<T> {
    let marks = grid.enumerate().reduce(Dictionary<Int, T>(), combine: buildDict)
    return Grid(dimmension: grid.dimmension, contents: buildDict(marks, entry: (position, team)))
}

func isBoardFull<T>(grid: Grid<T>) -> Bool {
    return grid.filter({ $0 != nil }).count == grid.count
}

private func buildDict<K: Hashable, V>(var dict: [K: V], entry: (K, V?)) -> [K:V] {
    dict[entry.0] = entry.1
    return dict
}
