import TicTacToe
import Termbox
import SpriteSheet

struct Output {

    private static let sheet = TermboxSprites()

    private let dimmension: Int
    private let grid: [[UnicodeScalar]]
    private let size: (height: UInt, width: UInt)

    private var charactersPerSide: UInt {
        return UInt(2 * dimmension - 1) * UInt(Output.sheet.size)
    }

    init(board: Board<Bool>, size: (height: UInt, width: UInt)) {
        self.dimmension = board.dimmension
        self.grid = Sprite(sheet: Output.sheet).grid(board: board)
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

}
