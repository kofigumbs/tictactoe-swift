import TicTacToe
import Termbox

enum Input: Equatable {
    case up, down, left, right, select, none

    init(event: Event) {
        guard case .key(let key) = event else { self = .none; return }

        switch key {
        case .arrowUp:
            self = .up
        case .arrowDown:
            self = .down
        case .arrowLeft:
            self = .left
        case .arrowRight:
            self = .right
        case .enter:
            self = .select
        default:
            self = .none
        }
    }

    func adjustedCursor(old: Int, board: Board<Bool>) -> Int {
        let constrained: (Int) -> Int = { $0 >= 0 && $0 < board.count ? $0 : old }

        switch self {
        case .up:
            return constrained(old - board.dimmension)
        case .down:
            return constrained(old + board.dimmension)
        case .left:
            return constrained(old % board.dimmension == 0 ? old : old - 1)
        case .right:
            return constrained(old % board.dimmension == board.dimmension - 1 ? old : old + 1)
        case .select:
            return old
        case .none:
            return old
        }
    }

    static func ==(lhs: Input, rhs: Input) -> Bool {
        switch (lhs, rhs) {
        case (.up, .up):
            return true
        case (.down, .down):
            return true
        case (.left, .left):
            return true
        case (.right, .right):
            return true
        case (.select, .select):
            return true
        case (.none, .none):
            return true
        default:
            return false
        }
    }

}
