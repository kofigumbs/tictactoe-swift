import TicTacToe
import Jay

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
        guard let curr = next else { return }
        next = nil
        curr(move)
    }

    private func encode(board: Board<Bool>, over: Bool) throws -> String {
        let game: [String: Any] = [
            "board": board.map(encode),
            "over": over
        ]
        return try Jay().dataFromJson(anyDictionary: game).string
    }

    private func encode(mark: Bool?) -> String {
        return mark.map { $0 ? "X" : "O" } ?? ""
    }

    private func safely(f: () throws -> ()) {
        do {
            try f()
        } catch {
        }
    }

}
