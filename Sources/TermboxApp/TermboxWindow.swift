import Termbox
import Core

class TermboxWindow: Window {

    private var cursor = 0
    private var board: Board<Bool> = Board(dimmension: 0)
    private let marks: (UnicodeScalar, UnicodeScalar) = (":", "X")
    private let termbox = Termbox()

    public func promptUserForIndex() -> Int {
        waitForInput()
        return cursor
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

    func draw(board: Board<Bool>) {
        self.board = board
        draw()
    }

    private func draw() {
        paint()
        termbox.present()
    }

    private func paint() {
        (UInt(0) ..< termbox.size.height).forEach({ i in
            (UInt(0) ..< termbox.size.width).forEach(({ j in paintCell(col: j, row: i) })) })
    }

    private func paintCell(col x: UInt, row y: UInt) {
        let (character, highlight) = determineCellContents(col: x, row: y)
        let background: Color = highlight ? .cyan : .black
        let cell: Cell = (character: character, foreground: .white, background: background)
        termbox.change(x: x, y: y, cell: cell)
    }

    private func determineCellContents(col x: UInt, row y: UInt) -> (UnicodeScalar, Bool) {
        if dividerCells(dimmension: termbox.size.height).contains(y)  {
            return ("-", false)
        } else if dividerCells(dimmension: termbox.size.width).contains(x) {
            return ("|", false)
        } else {
            let index = occupyingCell(col: x, row: y)
            return (boardChar(at: index) ?? " ", index == UInt(cursor))
        }
    }

    private func occupyingCell(col x: UInt, row y: UInt) -> UInt {
        let i = defineIndex(at: x, bound: termbox.size.width)
        let j = defineIndex(at: y, bound: termbox.size.height)
        return i + j * UInt(board.dimmension)
    }

    private func defineIndex(at target: UInt, bound: UInt) -> UInt {
        let divider = dividerCells(dimmension: bound)
        var i = divider.count
        while i > 0 && divider[i - 1] > target { i -= 1 }
        return UInt(i)
    }

    private func dividerCells(dimmension: UInt) -> [UInt] {
        let side = UInt(board.dimmension)
        return (UInt(1) ..< side).map({ $0 * dimmension / side })
    }

    private func boardChar(at index: UInt) -> UnicodeScalar? {
        return board[Int(index)].map { $0 ? marks.0 : marks.1 }
    }

}
