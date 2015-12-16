import UI

class StubWindow: Window {

    private var responses: [Int]
    var draws: Int = 0

    init(responses: [Int] = []) { self.responses = responses }

    func promptUserForIndex() -> Int { return responses.popLast()! }
    func drawGrid(grid: Grid<String>) { draws++ }

}

