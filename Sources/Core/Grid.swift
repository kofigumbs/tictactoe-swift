public struct Grid<T: Hashable>: Collection {

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

    public subscript(index: Int) -> T? { return contents[index] }

    public func index(after i: Int) -> Int {
        return i + 1
    }

}

private extension Dictionary where Key: Integer {
    mutating func bound(startingWith start: Key, endingWith end: Key) {
        self.keys
            .filter({ $0 >= end || $0 < start })
            .forEach({ self.removeValue(forKey: $0) })
    }
}
