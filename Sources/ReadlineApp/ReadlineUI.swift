import TicTacToe

struct ReadlineUI: UserInterface {

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)

        var input: Int? = nil
        repeat {
            print("\n>> ", terminator: "")
            input = readLine().flatMap { Int($0) }
        } while input == nil

        move(input!)
    }

    func end(board: Board<Bool>) {
        draw(board: board)
    }

    private func draw(board: Board<Bool>) {
        for line in grid(board: board) {
            line.forEach { print($0, terminator: "") }
            print("")
        }
    }

    private func grid(board: Board<Bool>) -> [[UnicodeScalar]] {
        let d = board.dimmension
        let strings: [[[String]]] = (0 ..< d)
            .map { board[$0 * d ..< $0 * d + d ] }
            .map { $0.map(mark) }
            .map { $0.intersperse(Text.vertical) }
            .intersperse(alternatingLine(d))

        return flatten(strings: strings)
    }

    private func mark(team: Bool?) -> [String] {
        return team.map { $0 ? Text.x : Text.o } ?? Text.empty
    }

    private func alternatingLine(_ radius: Int) -> [[String]] {
        return (0 ..< radius)
            .map { _ in Text.horizontal }
            .intersperse(Text.junction)
    }

    private func flatten(strings: [[[String]]]) -> [[UnicodeScalar]] {
        return strings.reduce([]) { acc, row in
            var flattened = Array(repeating: [UnicodeScalar](), count: 4)

            for sprite in row {
                for (i, line) in sprite.enumerated() {
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
