import UI

func markBoard<T>(grid: Grid<T>, position: Int, team: T) -> Grid<T> {
    var marks = Dictionary<Int, T>()
    grid.enumerate().forEach({ marks[$0.0] = $0.1 })
    marks[position] = team
    return Grid(dimmension: grid.dimmension, contents: marks)
}

func isBoardFull<T>(grid: Grid<T>) -> Bool {
    return grid.filter({ $0 != nil }).count == grid.count
}