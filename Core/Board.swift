import UI

struct Board<T: Hashable>: CollectionType, Hashable {

    private var grid: Grid<T>

    var dimmension: Int { return grid.dimmension }
    var startIndex: Int { return grid.startIndex }
    var endIndex: Int { return grid.endIndex }
    var isEmpty: Bool { return grid.isEmpty }
    var isFull: Bool { return flatMap({ $0 }).count == count }
    var hashValue: Int { return reduce("", combine: { $0 + String($1) }).hashValue }

    init(dimmension: Int, contents: [Int: T]) {
        self.grid = Grid<T>(dimmension: dimmension, contents: contents)
    }

    subscript(index: Int) -> T? { return grid[index] }

    func markAt(position: Int, with team: T) -> Board<T> {
        var contents = grid.contents
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

    func availableSpaces() -> [Int] {
        return enumerate().filter({ $0.element == nil }).map({ $0.index })
    }

}

func ==<T: Hashable>(lhs: Board<T>, rhs: Board<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
