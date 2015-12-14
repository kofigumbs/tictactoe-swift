import UI

public struct Board<T: Hashable>: CollectionType, Hashable {

    public var startIndex: Int { return grid.startIndex }
    public var endIndex: Int { return grid.endIndex }
    public var isEmpty: Bool { return grid.isEmpty }
    public var hashValue: Int { return reduce("", combine: { $0 + String($1) }).hashValue }
    public subscript(index: Int) -> T? { return grid[index] }

    let grid: Grid<T>
    var isFull: Bool { return flatMap({ $0 }).count == count }
    var dimmension: Int { return grid.dimmension }

    public init(dimmension: Int, contents: [Int:T] = Dictionary()) {
        self.grid = Grid<T>(dimmension: dimmension, contents: contents)
    }

    func markAt(position: Int, with team: T) -> Board<T> {
        var contents = grid.contents
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

    func availableSpaces() -> [Int] {
        return enumerate().filter({ $0.element == nil }).map({ $0.index })
    }

}

public func ==<T: Hashable>(lhs: Board<T>, rhs: Board<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
