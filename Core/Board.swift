import UI

struct Board<T: Hashable>: CollectionType {

    private var grid: Grid<T>

    var dimmension: Int { return grid.dimmension }
    var startIndex: Int { return grid.startIndex }
    var endIndex: Int { return grid.endIndex }
    var isEmpty: Bool { return grid.isEmpty }
    var isFull: Bool { return grid.flatMap({ $0 }).count == grid.count }

    init(dimmension: Int, contents: [Int: T]) {
        self.grid = Grid<T>(dimmension: dimmension, contents: contents)
    }

    subscript(index: Int) -> T? { return grid[index] }

    func availableSpaces() -> [Int] {
        return grid.enumerate().filter({ $0.element == nil }).map({ $0.index })
    }

    func markAt(position: Int, with team: T) -> Board<T> {
        var contents = Dictionary<Int, T>()
        grid.enumerate().forEach({ contents[$0.index] = $0.element })
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

}
