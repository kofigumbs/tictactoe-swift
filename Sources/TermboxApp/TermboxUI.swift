import TicTacToe
import Termbox

class TermboxUI: UserInterface {

    private let termbox = Termbox()
    private var cursor = 0
    private let fin = "FIN: press any key to quit."

    public func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)
        waitForMove(board: board)
        move(cursor)
    }

    public func end(board: Board<Bool>) {
        draw(board: board)
        for (i, u) in fin.unicodeScalars.enumerated() {
            termbox.change(x: UInt(i), y: termbox.size.width - 1, cell: (u, .red, .none))
        }
        termbox.present()
        let _ = termbox.poll()
    }

    private func waitForMove(board: Board<Bool>) {
        var input = Input.none
        repeat {
            input = Input(event: termbox.poll())
            cursor = input.adjustedCursor(old: cursor, board: board)
            draw(board: board)
        } while input != .select
    }

    private func draw(board: Board<Bool>) {
        let spriteSheet = SpriteSheet(board: board, size: termbox.size)

        for i in 0 ..< termbox.size.width {
            for j in 0 ..< termbox.size.height {
                termbox.change(x: i, y: j, cell: spriteSheet.cell(x: i, y: j, cursor: cursor))
            }
        }

        termbox.present()
    }

}
