public typealias Board<T: Hashable> = Grid<T>

extension Grid: Equatable {
    var isFull: Bool { return flatMap({ $0 }).count == count }

    func marked(at position: Int, with team: T) -> Board<T> {
        var contents = self.contents
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

    func availableSpaces() -> [Int] {
        return enumerated().filter({ $0.element == nil }).map({ $0.offset })
    }

    public static func ==<T: Hashable>(lhs: Board<T>, rhs: Board<T>) -> Bool {
        return lhs.enumerated().reduce(true) { $0 && $1.element == rhs[$1.offset]  }
    }
}


