public struct Grid<T: Equatable>: CollectionType {

    public let startIndex = 0
    public let endIndex: Int
    public let dimmension: Int
    public let isEmpty: Bool

    private let contents: [(Int, T)]

    public init(dimmension:Int, contents dictionary: [Int: T] = Dictionary()){
        let endIndex = dimmension * dimmension
        let bounds = startIndex ..< endIndex
        let contents = dictionary.filter({ bounds.contains($0.0) })

        self.endIndex = endIndex
        self.dimmension = dimmension
        self.contents = contents
        self.isEmpty = contents.isEmpty
    }

    public subscript(index: Int) -> T? {
        return contents.filter({ $0.0 == index }).map({ $0.1 }).first
    }

}
