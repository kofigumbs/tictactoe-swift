public struct Grid<T: Equatable>: CollectionType {
    public let startIndex = 0
    public let endIndex: Int
    public let dimmension: Int
    public let isEmpty: Bool

    private let contents: [Int: T]

    public init(dimmension:Int, contents: (Int, T)...) {
        self.contents = convertTuplesToDictionary(contents)
        self.dimmension = dimmension
        self.endIndex = dimmension * dimmension
        self.isEmpty = contents.isEmpty
    }

    public subscript(index: Int) -> T? {
        return contents[index]
    }

}

private func convertTuplesToDictionary<K, V>(tuples: [(K, V)]) -> [K: V] {
    var dictionary: [K: V] = Dictionary()
    tuples.forEach({ dictionary[$0.0] = $0.1 })
    return dictionary
}
