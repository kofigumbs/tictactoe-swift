import CTermbox
import Core

class TermboxWindow<T: Hashable>: Window {

    private var cursor = 0
    private var board: Board<T> = Board(dimmension: 0)
    private var marksInUse: [T: UInt32] = Dictionary()
    private var marksAvailable: [UInt32] = [ASCII_COLON, ASCII_X]

    init() { let _ = CTermbox.tb_init() }
    deinit { let _ = CTermbox.tb_shutdown() }

    public func promptUserForIndex() -> Int {
        pollForEnter()
        return cursor
    }

    private func pollForEnter() -> Void {
        var key: UInt16
        repeat {
            key = pollKey()
            if key == TB_KEY_ARROW_DOWN {
                adjustCursor(diff: board.dimmension)
            } else if key == TB_KEY_ARROW_UP {
                adjustCursor(diff: -board.dimmension)
            } else if key == TB_KEY_ARROW_LEFT {
                adjustCursor(diff: cursor % board.dimmension == 0 ? 0 : -1)
            } else if key == TB_KEY_ARROW_RIGHT {
                adjustCursor(diff: cursor % board.dimmension == board.dimmension - 1 ? 0 : 1)
            }
        } while key != TB_KEY_ENTER
    }

    private func pollKey() -> UInt16 {
        let event = UnsafeMutablePointer<CTermbox.tb_event>.allocate(capacity: 1)
        let _ = CTermbox.tb_poll_event(event)
        let key = event.pointee.key
        event.deallocate(capacity: 1)
        return key
    }

    private func adjustCursor(diff: Int) {
        let proposed = cursor + diff
        if proposed >= 0 && proposed < board.count {
            self.cursor = proposed
            redrawBoard()
        }
    }

    func draw(board: Board<T>) {
        self.board = board
        redrawBoard()
    }

    private func redrawBoard() {
        paintEachCell()
        let _ = CTermbox.tb_present()
    }

    private func paintEachCell() {
        (Int32(0) ..< CTermbox.tb_height()).forEach({ i in
            (Int32(0) ..< CTermbox.tb_width()).forEach(({ j in paintCell(col: j, row: i) })) })
    }

    private func paintCell(col x: Int32, row y: Int32) {
        let (char, highlight) = determineCellContents(col: x, row: y)
        let background = highlight ? TB_CYAN : TB_BLACK
        let _ = CTermbox.tb_change_cell(x, y, char, TB_WHITE, background)
    }

    private func determineCellContents(col x: Int32, row y: Int32) -> (UInt32, Bool) {
        if dividerCells(dimmension: CTermbox.tb_height()).contains(y)  {
            return (ASCII_HYPHEN, false)
        } else if dividerCells(dimmension: CTermbox.tb_width()).contains(x) {
            return (ASCII_PIPE, false)
        } else {
            let index = occupyingCell(col: x, row: y)
            return (boardChar(at: index) ?? ASCII_SPACE, index == cursor)
        }
    }

    private func occupyingCell(col x: Int32, row y: Int32) -> Int {
        let i = defineIndex(at: x, bound: CTermbox.tb_width())
        let j = defineIndex(at: y, bound: CTermbox.tb_height())
        return i + j * board.dimmension
    }

    private func defineIndex(at target: Int32, bound: Int32) -> Int {
        let divider = dividerCells(dimmension: bound)
        var i = divider.count
        while i > 0 && divider[i - 1] > target { i -= 1 }
        return i
    }

    private func boardChar(at index: Int) -> UInt32? {
        return board[index].map({ fetchMark(for: $0) })
    }

    private func fetchMark(for team: T) -> UInt32 {
        if let mark = marksInUse[team] {
            return mark
        } else {
            let mark = marksAvailable.popLast()!
            marksInUse[team] = mark
            return mark
        }
    }

    private func dividerCells(dimmension: Int32) -> [Int32] {
        return (Int32(1) ..< Int32(board.dimmension)).map({ $0 * dimmension / Int32(board.dimmension) })
    }

}

