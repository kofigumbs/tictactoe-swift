import UI

class StubWindow: Window {

    private var responses: [String]
    var draws: Int = 0

    init(responses: [String] = []) { self.responses = responses }

    func promptUser(prompt: String) -> String { return responses.popLast()! }
    func drawGrid<T: Equatable>(grid: Grid<T>) { draws++ }
    func printMessage(message: String) {}

}

