import TicTacToe

class StubUI: UserInterface {

    var responses: [Int]
    var ends: Int = 0

    init(responses: [Int] = []) {
        self.responses = responses
    }

    func prompt(board: Board<String>, move: @escaping (Int) -> Void) {
        responses.popLast().map(move)
    }

    func end(board: Board<String>) {
        ends += 1
    }

}
