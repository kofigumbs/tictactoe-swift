import TicTacToe

public struct Sprite<S: Sheet> {
    let sheet: S

    public init(sheet: S) {
        self.sheet = sheet
    }

    public func grid(board: Board<Bool>) -> [[UnicodeScalar]] {
        let d = board.dimmension
        let strings: [[[String]]] = (0 ..< d)
            .map { board[$0 * d ..< $0 * d + d ] }
            .map { $0.map(mark) }
            .map { $0.intersperse(self.sheet.vertical) }
            .intersperse(alternatingLine(d))

        return flatten(strings: strings)
    }

    private func mark(team: Bool?) -> [String] {
        return team.map { $0 ? self.sheet.x : self.sheet.o } ?? sheet.empty
    }

    private func alternatingLine(_ radius: Int) -> [[String]] {
        return (0 ..< radius)
            .map { _ in self.sheet.horizontal }
            .intersperse(sheet.junction)
    }

    private func flatten(strings: [[[String]]]) -> [[UnicodeScalar]] {
        return strings.reduce([]) { acc, row in
            var flattened = Array(repeating: [UnicodeScalar](), count: sheet.size)

            for sheet in row {
                for (i, line) in sheet.enumerated() {
                    for character in line.unicodeScalars {
                        flattened[i].append(character)
                    }
                }
            }

            return acc + flattened
        }
    }

}

private extension Collection {

    typealias E = Self.Iterator.Element

    func intersperse(_ separator: E) -> [E] {
        let slice = reduce([]) { (acc: [E], curr: E) -> [E] in
            return acc + [curr] + [separator]
        }.dropLast(1)
        return Array(slice)
    }

}
