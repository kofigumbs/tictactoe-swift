public class Human<Win: Window>: Player {

    public let team: Win.Mark
    private let window: Win

    public init(team: Win.Mark, window: Win) {
        self.team = team
        self.window = window
    }

    public func evaluate(board: Board<Win.Mark>) -> Int {
        window.draw(board: board)
        var attempt: Int
        repeat {
            attempt = window.promptUserForIndex()
        } while !board.availableSpaces().contains(attempt)
        return attempt
    }

}
