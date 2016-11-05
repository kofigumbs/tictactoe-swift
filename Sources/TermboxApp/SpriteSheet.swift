import TicTacToe
import Termbox

struct SpriteSheet {

    private static let X = [
        "x    x",
        " x  x ",
        "  xx  ",
        "  xx  ",
        " x  x ",
        "x    x"
    ]

    private static let O = [
        " oooo ",
        "oooooo",
        "oo  oo",
        "oo  oo",
        "oooooo",
        " oooo "
    ]

    private static let EMPTY = [
        "      ",
        "      ",
        "      ",
        "      ",
        "      ",
        "      "
    ]

    private static let HORIZONTAL = [
        "      ",
        "      ",
        "======",
        "======",
        "      ",
        "      "
    ]

    private static let VERTICAL = [
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  "
    ]

    private static let JUNCTION = [
        "  ||  ",
        "  ||  ",
        "==++==",
        "==++==",
        "  ||  ",
        "  ||  "
    ]



    //-- INSTANCE --//


    let board: Board<Bool>
    let size: (height: UInt, width: UInt)

    private var charactersPerSide: UInt {
        return UInt(2 * board.dimmension - 1) * 6
    }

    private var grid: [[UnicodeScalar]] {
        let strings: [[[String]]] = (0 ..< board.dimmension)
            .map { board[$0 * board.dimmension ..< $0 * board.dimmension + board.dimmension ] }
            .map { $0.map(SpriteSheet.mark) }
            .map { $0.intersperse(SpriteSheet.VERTICAL) }
            .intersperse(SpriteSheet.alternatingLine(board.dimmension))

        return SpriteSheet.flatten(strings: strings)
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
        return normalized(x) + normalized(y) * board.dimmension
    }

    private func normalized(_ n: Int) -> Int {
        return n * board.dimmension / Int(charactersPerSide)
    }

    private static func mark(team: Bool?) -> [String] {
        return team.map { $0 ? X : O } ?? EMPTY
    }

    private static func alternatingLine(_ radius: Int) -> [[String]] {
        return (0 ..< radius)
            .map { _ in HORIZONTAL }
            .intersperse(JUNCTION)
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

    func intersperse(_ separator: Self.Iterator.Element) -> [Self.Iterator.Element] {
        let slice = reduce([]) { (acc: [Self.Iterator.Element], curr: Self.Iterator.Element) -> [Self.Iterator.Element] in
            return acc + [curr] + [separator]
        }.dropLast(1)
        return Array(slice)
    }

}

private extension String {

    subscript(_ i: Int) -> UnicodeScalar {
        let u = unicodeScalars
        return u[u.index(u.startIndex, offsetBy: i)]
    }

}
