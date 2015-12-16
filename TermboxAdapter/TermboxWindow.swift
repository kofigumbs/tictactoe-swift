import Termbox
import UI

public class TermboxWindow<T: Hashable>: Window {

    private let TB_KEY_ARROW_UP     = UInt16(0xFFFF-18)
    private let TB_KEY_ARROW_DOWN   = UInt16(0xFFFF-19)
    private let TB_KEY_ARROW_LEFT   = UInt16(0xFFFF-20)
    private let TB_KEY_ARROW_RIGHT  = UInt16(0xFFFF-21)
    private let TB_KEY_ENTER        = UInt16(0x0D)

    private let TB_BLACK            = UInt16(0x01)
    private let TB_CYAN             = UInt16(0x07)
    private let TB_WHITE            = UInt16(0x08)

    private let ASCII_SPACE         = UInt32(32)
    private let ASCII_HYPHEN        = UInt32(45)
    private let ASCII_PIPE          = UInt32(124)

    private var cursor = 0
    private var grid: Grid<T> = Grid(dimmension: 0)
    private var marksInUse: [T: UInt32] = Dictionary()
    private var marksAvailable: [UInt32] = [UInt32(58), UInt32(88)]

    public init() { tb_init() }
    public func destroy() {
        print("Press any key to exit...")
        _ = pollKey()
        tb_shutdown()
    }

    public func printMessage(message: String) { }

    public func promptUser(_: String) -> String {
        pollForEnter()
        return String(cursor)
    }

    private func pollForEnter() -> Void {
        var key: UInt16
        repeat {
            key = pollKey()
            if key == TB_KEY_ARROW_DOWN {
                adjustCursor(grid.dimmension)
            } else if key == TB_KEY_ARROW_UP {
                adjustCursor(-grid.dimmension)
            } else if key == TB_KEY_ARROW_LEFT {
                adjustCursor(cursor % grid.dimmension == 0 ? 0 : -1)
            } else if key == TB_KEY_ARROW_RIGHT {
                adjustCursor(cursor % grid.dimmension == grid.dimmension - 1 ? 0 : 1)
            }
        } while key != TB_KEY_ENTER
    }

    private func pollKey() -> UInt16 {
        let event = UnsafeMutablePointer<tb_event>.alloc(1)
        tb_poll_event(event)
        let key = event.memory.key
        event.dealloc(1)
        return key
    }

    private func adjustCursor(diff: Int) {
        let proposed = cursor + diff
        if proposed >= 0 && proposed < grid.count {
            self.cursor = proposed
            redrawGrid()
        }
    }

    public func drawGrid(grid: Grid<T>) {
        self.grid = grid
        redrawGrid()
    }

    private func redrawGrid() {
        paintEachCell()
        tb_present()
    }

    private func paintEachCell() {
        (Int32(0) ..< tb_height()).forEach({ i in
            (Int32(0) ..< tb_width()).forEach(({ j in paintCell(j, i) })) })
    }

    private func paintCell(x: Int32, _ y: Int32) {
        let (char, highlight) = determineCellContents(x, y)
        let background = highlight ? TB_CYAN : TB_BLACK
        tb_change_cell(x, y, char, TB_WHITE, background)
    }

    private func determineCellContents(x: Int32, _ y: Int32) -> (UInt32, Bool) {
        if dividerCells(tb_height()).contains(y)  {
            return (ASCII_HYPHEN, false)
        } else if dividerCells(tb_width()).contains(x) {
            return (ASCII_PIPE, false)
        } else {
            let index = occupyingCell(x, y)
            return (gridCharAt(index) ?? ASCII_SPACE, index == cursor)
        }
    }

    private func occupyingCell(x: Int32, _ y:Int32) -> Int {
        let i = defineIndex(x, bound: tb_width())
        let j = defineIndex(y, bound: tb_height())
        return i + j * grid.dimmension
    }

    private func defineIndex(target: Int32, bound: Int32) -> Int {
        let divider = dividerCells(bound)
        var i = divider.count
        while i > 0 && divider[i - 1] > target { i-- }
        return i
    }

    private func gridCharAt(gridIndex: Int) -> UInt32? {
        return grid[gridIndex].map({ fetchMarkFor($0) })
    }

    private func fetchMarkFor(team: T) -> UInt32 {
        if let mark = marksInUse[team] {
            return mark
        } else {
            let mark = marksAvailable.popLast()!
            marksInUse[team] = mark
            return mark
        }
    }

    private func dividerCells(dimmension: Int32) -> [Int32] {
        return (Int32(1) ..< Int32(grid.dimmension)).map({ $0 * dimmension / Int32(grid.dimmension) })
    }

}

