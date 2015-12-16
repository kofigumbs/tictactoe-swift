import UI

public class Human<W: Window>: Player {

    public let team: W.T
    private let window: W

    public init(team: W.T, window: W) { self.team = team; self.window = window }

    public func evaluate(board: Board<W.T>) -> Int {
        window.drawGrid(board.grid)
        var attempt: Int
        repeat {
            attempt = promptForMove()
        } while !board.availableSpaces().contains(attempt)
        return attempt
    }

    private func promptForMove() -> Int {
        var move: Int?
        repeat {
            move = Int(window.promptUser("Your turn"))
        } while move == nil
        return move!
    }

}
