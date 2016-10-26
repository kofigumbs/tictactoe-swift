public struct Board<T: Hashable>: Collection, Equatable {

    public var startIndex: Int { return grid.startIndex }
    public var endIndex: Int { return grid.endIndex }
    public var isEmpty: Bool { return grid.isEmpty }
    public subscript(index: Int) -> T? { return grid[index] }

    let grid: Grid<T>
    var isFull: Bool { return flatMap({ $0 }).count == count }
    var dimmension: Int { return grid.dimmension }

    public init(dimmension: Int, contents: [Int:T] = Dictionary()) {
        self.grid = Grid<T>(dimmension: dimmension, contents: contents)
    }

    func marked(at position: Int, with team: T) -> Board<T> {
        var contents = grid.contents
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

    func availableSpaces() -> [Int] {
        return enumerated().filter({ $0.element == nil }).map({ $0.offset })
    }

    public func index(after i: Int) -> Int {
        return grid.index(after: i)
    }

    public static func ==<T: Hashable>(lhs: Board<T>, rhs: Board<T>) -> Bool {
        return lhs.enumerated().reduce(true) { $0 && $1.element == rhs[$1.offset]  }
    }
}


