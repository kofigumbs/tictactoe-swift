import TicTacToe
import Termbox

struct SpriteSheet {

    private let dimmension: Int
    private let grid: [[UnicodeScalar]]
    private let size: (height: UInt, width: UInt)

    private var charactersPerSide: UInt {
        return UInt(2 * dimmension - 1) * 6
    }

    init(board: Board<Bool>, size: (height: UInt, width: UInt)) {
        self.dimmension = board.dimmension
        self.grid = SpriteSheet.grid(board: board)
        self.size = size
    }

    func cell(x: UInt, y: UInt, cursor: Int) -> Cell {
        let xMargin = (size.width - charactersPerSide) / 2
        let yMargin = (size.height - charactersPerSide) / 2

        if x < xMargin || x >= xMargin + charactersPerSide || y < yMargin || y >= yMargin + charactersPerSide {
            return (character: " ", foreground: .none, background: .none)
        } else {
            let xRelative = Int(x - xMargin)
            let yRelative = Int(y - yMargin)
            let character = grid[yRelative][xRelative]
            let foreground =  character == " " ? Color.none : Color.white
            let background = cursor == selected(x: xRelative, y: yRelative) ? Color.cyan : Color.none
            return (character: character, foreground: foreground, background: background)
        }
    }

    private func selected(x: Int, y: Int) -> Int {
        let normalized = { $0 * self.dimmension / Int(self.charactersPerSide) }
        return normalized(x) + normalized(y) * dimmension
    }

    private static func grid(board: Board<Bool>) -> [[UnicodeScalar]] {
        let d = board.dimmension
        let strings: [[[String]]] = (0 ..< d)
            .map { board[$0 * d ..< $0 * d + d ] }
            .map { $0.map(mark) }
            .map { $0.intersperse(Sprite.vertical) }
            .intersperse(alternatingLine(d))

        return flatten(strings: strings)
    }

    private static func mark(team: Bool?) -> [String] {
        return team.map { $0 ? Sprite.x : Sprite.o } ?? Sprite.empty
    }

    private static func alternatingLine(_ radius: Int) -> [[String]] {
        return (0 ..< radius)
            .map { _ in Sprite.horizontal }
            .intersperse(Sprite.junction)
    }

    private static func flatten(strings: [[[String]]]) -> [[UnicodeScalar]] {
        return strings.reduce([]) { acc, row in
            var flattened = Array(repeating: [UnicodeScalar](), count: 6)

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
