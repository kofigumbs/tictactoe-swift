public struct Grid<T: Equatable>: CollectionType {

    public let startIndex = 0
    public let endIndex: Int
    public let dimmension: Int
    public let isEmpty: Bool
    public let contents: [Int: T]

    public init(dimmension:Int, var contents: [Int: T] = Dictionary()){
        let endIndex = dimmension * dimmension
        contents.bound(startIndex, endIndex)

        self.endIndex = endIndex
        self.dimmension = dimmension
        self.contents = contents
        self.isEmpty = contents.isEmpty
    }

    public subscript(index: Int) -> T? { return contents[index] }

}

private extension Dictionary where Key: IntegerType {
    mutating func bound(startKey: Key, _ endKey: Key) {
        self.keys
            .filter({ $0 >= endKey || $0 < startKey })
            .forEach({ self.removeValueForKey($0) })
    }
}
