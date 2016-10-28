public struct Board<T: Hashable>: Collection, Equatable {

    public let startIndex = 0
    public let endIndex: Int
    public let dimmension: Int
    public let isEmpty: Bool
    public let contents: [Int:T]

    public init(dimmension:Int, contents: [Int:T] = Dictionary()) {
        var contents = contents
        let endIndex = dimmension * dimmension

        contents.bound(startingWith: startIndex, endingWith: endIndex)

        self.endIndex = endIndex
        self.dimmension = dimmension
        self.contents = contents
        self.isEmpty = contents.isEmpty
    }

    public subscript(index: Int) -> T? {
        return contents[index]
    }

    public func index(after i: Int) -> Int {
        return i + 1
    }

    var isFull: Bool { return flatMap({ $0 }).count == count }

    func marked(at position: Int, with team: T) -> Board<T> {
        var contents = self.contents
        contents[position] = team
        return Board(dimmension: dimmension, contents: contents)
    }

    func availableSpaces() -> [Int] {
        return enumerated()
            .filter { $0.element == nil }
            .map { $0.offset }
    }

    public static func ==<T: Hashable>(lhs: Board<T>, rhs: Board<T>) -> Bool {
        return lhs.enumerated().reduce(true) { $0 && $1.element == rhs[$1.offset]  }
    }
}

private extension Dictionary where Key: Integer {
    func bounded(startingWith start: Key, endingWith end: Key) {
        self.keys
            .filter({ $0 >= end || $0 < start })
            .forEach({ self.removeValue(forKey: $0) })
    }
}
