import TicTacToe
import Core
import JSON

class ServerUI: UserInterface {

    private let update: (Bytes) throws -> ()
    private var next: ((Int) -> Void)?

    init(update: @escaping (Bytes) throws -> ()) {
        self.update = update
    }

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        next = move
        try? update(encode(board: board, over: false))
    }

    func end(board: Board<Bool>) {
        try? update(encode(board: board, over: true))
    }

    func send(move: Int) {
        guard let curr = next else { return }
        next = nil
        curr(move)
    }

    private func encode(board: Board<Bool>, over: Bool) throws -> Bytes {
        var json = JSON()
        try json.set("board", board.map(encode))
        try json.set("over", over)
        return try json.serialize()
    }

    private func encode(mark: Bool?) -> String {
        return mark.map { $0 ? "X" : "O" } ?? ""
    }

}
