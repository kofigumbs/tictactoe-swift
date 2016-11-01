import TicTacToe
import Termbox

class TermboxUI: UserInterface {

    private var cursor = 0
    private var board: Board<Bool> = Board(dimmension: 0)
    private let termbox = Termbox()

    public func prompt(on board: Board<Bool>, move: (Int) -> Void) {
        self.board = board
        waitForValidCursor()
        move(cursor)
    }

    private func waitForValidCursor() {
        draw()
        repeat {
            waitForInput()
        } while !board.availableSpaces().contains(cursor)

    }

    private func waitForInput() -> Void {
        while true {
            switch termbox.poll()  {
            case .key(let key):
                switch key {
                case .arrowDown:
                    adjustCursor(diff: board.dimmension)
                case .arrowUp:
                    adjustCursor(diff: -board.dimmension)
                case .arrowLeft:
                    adjustCursor(diff: cursor % board.dimmension == 0 ? 0 : -1)
                case .arrowRight:
                    adjustCursor(diff: cursor % board.dimmension == board.dimmension - 1 ? 0 : 1)
                case .enter:
                    return
                default:
                    break
                }
            default:
                break
            }
        }
    }

    private func adjustCursor(diff: Int) {
        let proposed = cursor + diff
        if proposed >= 0 && proposed < board.count {
            self.cursor = proposed
            draw()
        }
    }

    private func draw() {
        paint()
        termbox.present()
    }

    private func paint() {
        (UInt(0) ..< termbox.size.height).forEach { i in
            (UInt(0) ..< termbox.size.width).forEach { j in paint(col: j, row: i) }
        }
    }

    private func paint(col x: UInt, row y: UInt) {
        let spot = spotCheck(col: x, row: y)
        termbox.change(x: x, y: y, cell: spot.present())
    }

    private func spotCheck(col x: UInt, row y: UInt) -> Spot {
        if dividerCells(dimmension: termbox.size.height).contains(y) {
            return .horizontalDivider
        } else if dividerCells(dimmension: termbox.size.width).contains(x) {
            return .verticalDivider
        } else {
            let i = defineBoundary(at: x, dimmension: termbox.size.width)
            let j = defineBoundary(at: y, dimmension: termbox.size.height)
            let position = i + j * board.dimmension
            let selected = position == cursor
            return board[position].map { .taken(team: $0, selected: selected) } ?? .empty(selected: selected)
        }
    }

    private func defineBoundary(at target: UInt, dimmension: UInt) -> Int {
        let divider = dividerCells(dimmension: dimmension)
        return divider.reversed().reduce(divider.count) { acc, div in
            div > target && acc > 0 ? acc - 1 : acc
        }
    }

    private func dividerCells(dimmension: UInt) -> [UInt] {
        let side = UInt(board.dimmension)
        return (UInt(1) ..< side).map { $0 * dimmension / side }
    }

}
