import TicTacToe

class ServerUI: UserInterface {

    private let update: (String) throws -> ()
    private var next: ((Int) -> Void)?

    init(update: @escaping (String) throws -> ()) {
        self.update = update
    }

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        next = move
        safely { try update(encode(board: board, over: false)) }
    }

    func end(board: Board<Bool>) {
        safely { try update(encode(board: board, over: true)) }
    }

    func send(move: Int) {
        guard let next = next else { return }
        self.next = nil
        next(move)
    }

    private func encode(board: Board<Bool>, over: Bool) -> String {
        let grid = board.map(encode).joined(separator: ",")
        return "{ \"board\": [\(grid)], \"over\": \(over) }"
    }

    private func encode(mark: Bool?) -> String {
        return mark.map { $0 ? "\"X\"" : "\"O\"" } ?? "null"
    }

    private func safely(_ f: () throws -> ()) {
        do {
            try f()
        } catch {
        }
    }

}
