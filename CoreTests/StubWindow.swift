import UI

class StubWindow: Window {

    private var responses: [String]
    var draws: Int = 0

    init(responses: [String] = []) { self.responses = responses }

    func promptUser(prompt: String) -> String { return responses.popLast()! }
    func drawGrid(grid: Grid<String>) { draws++ }
    func printMessage(message: String) {}

}

