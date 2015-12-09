public struct Grid<T: Equatable>: CollectionType {
    public let startIndex = 0
    public let endIndex: Int
    public let dimmension: Int
    public let isEmpty: Bool

    private let contents: [Int: T]

    public init(dimmension:Int, contents tuples: (Int, T)...) {
        let endIndex = dimmension * dimmension
        let contents = convertTuplesToDictionary(tuples, bounds: 0...endIndex)

        self.endIndex = endIndex
        self.dimmension = dimmension
        self.contents = contents
        self.isEmpty = contents.isEmpty
    }

    public subscript(index: Int) -> T? {
        return contents[index]
    }

}

private func convertTuplesToDictionary<K, V>(tuples: [(K, V)], bounds: Range<K>) -> [K: V] {
    var dictionary: [K: V] = Dictionary()
    tuples.filter({ bounds.contains($0.0) }).forEach({ dictionary[$0.0] = $0.1 })
    return dictionary
}
