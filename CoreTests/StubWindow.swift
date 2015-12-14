import UI

class StubWindow: Window {

    private var responses: [String]

    init(responses: [String]) { self.responses = responses }

    func promptUser(prompt: String) -> String { return responses.popLast()! }
    func drawGrid<T: Equatable>(grid: Grid<T>) {}
    func printMessage(message: String) {}

}

