import UI

func isBoardFull<T>(grid: Grid<T>) -> Bool {
    return grid.filter({ $0 != nil }).count == grid.count
}

func availableSpaces<T>(grid: Grid<T>) -> [Int] {
    return grid.enumerate().filter({ $0.element == nil }).map({ $0.index })
}

func markBoard<T>(grid: Grid<T>, position: Int, team: T) -> Grid<T> {
    let marks = grid.enumerate().reduce(Dictionary<Int, T>(), combine: buildDict)
    return Grid(dimmension: grid.dimmension, contents: buildDict(marks, entry: (position, team)))
}

private func buildDict<K: Hashable, V>(var dict: [K: V], entry: (K, V?)) -> [K:V] {
    let (key, value) = entry
    dict[key] = value
    return dict
}
