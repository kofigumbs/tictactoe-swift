import Core

class StubUI: UserInterface {

    private var responses: [Int]
    var draws: Int = 0

    init(responses: [Int] = []) {
        self.responses = responses
    }

    func prompt(on board: Board<String>, move: (Int) -> Void) {
        responses.popLast().map(move)
    }

}
