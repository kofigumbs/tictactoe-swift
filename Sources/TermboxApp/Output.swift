import TicTacToe
import SpriteSheet
import Termbox

struct Output {

    private static let sheet = TermboxSprites()

    private let dimmension: Int
    private let grid: [[UnicodeScalar]]
    private let height: Int32
    private let width: Int32

    private var charactersPerSide: Int32 {
        return Int32(2 * dimmension - 1) * Int32(Output.sheet.size)
    }

    init(board: Board<Bool>, height: Int32, width: Int32) {
        self.dimmension = board.dimmension
        self.grid = Sprite(sheet: Output.sheet).grid(board: board)
        self.height = height
        self.width = width
    }

    func cell(x: Int32, y: Int32, cursor: Int) -> (UnicodeScalar, Attributes, Attributes) {
        let xMargin = (width - charactersPerSide) / 2
        let yMargin = (height - charactersPerSide) / 2

        if x < xMargin || x >= xMargin + charactersPerSide || y < yMargin || y >= yMargin + charactersPerSide {
            return (" ", .default, .default)
        } else {
            let xRelative = Int(x - xMargin)
            let yRelative = Int(y - yMargin)
            let character = grid[yRelative][xRelative]
            return (
                character,
                character == " " ? Attributes.default : Attributes.white,
                cursor == selected(x: xRelative, y: yRelative) ? Attributes.cyan : Attributes.default
            )
        }
    }

    private func selected(x: Int, y: Int) -> Int {
        let normalized = { $0 * self.dimmension / Int(self.charactersPerSide) }
        return normalized(x) + normalized(y) * dimmension
    }

}
