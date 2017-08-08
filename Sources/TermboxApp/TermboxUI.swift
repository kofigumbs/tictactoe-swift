import TicTacToe
import Termbox

class TermboxUI: UserInterface {

    private var cursor = 0
    private let fin = " FIN: press any key to exit. "

    public func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)
        waitForMove(board: board)
        move(cursor)
    }

    public func end(board: Board<Bool>) {
        draw(board: board)
        for (i, u) in fin.unicodeScalars.enumerated() {
            Termbox.put(x: Int32(i), y: Termbox.height - 1, character: u, foreground: .red, background: .white)
        }
        Termbox.present()
        let _ = Termbox.pollEvent()
    }

    private func waitForMove(board: Board<Bool>) {
        var input = Input.none
        repeat {
            input = Input(event: Termbox.pollEvent())
            cursor = input.adjustedCursor(old: cursor, board: board)
            draw(board: board)
        } while input != .select
    }

    private func draw(board: Board<Bool>) {
        let output = Output(board: board, height: Termbox.height, width: Termbox.width)

        for i in 0 ..< Termbox.width {
            for j in 0 ..< Termbox.height {
                let ( ch, fg, bg ) = output.cell(x: i, y: j, cursor: cursor)
                Termbox.put(x: i, y: j, character: ch, foreground: fg, background: bg)
            }
        }

        Termbox.present()
    }

}
