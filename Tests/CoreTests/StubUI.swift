import Core

class StubUI: UserInterface {

    private var responses: [Int]
    var draws: Int = 0

    init(responses: [Int] = []) {
        self.responses = responses
    }

    func promptMove(on board: Board<String>) -> Int {
        return responses.popLast()!
    }

}
