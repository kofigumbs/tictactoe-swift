public class Human<W: Window>: Player {

    public let team: W.T
    private let window: W

    public init(team: W.T, window: W) { self.team = team; self.window = window }

    public func evaluate(board: Board<W.T>) -> Int {
        window.draw(grid: board.grid)
        var attempt: Int
        repeat {
            attempt = window.promptUserForIndex()
        } while !board.availableSpaces().contains(attempt)
        return attempt
    }

}
