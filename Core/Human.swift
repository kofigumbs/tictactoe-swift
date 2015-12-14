import UI

public class Human<T: Hashable>: Player {

    public let team: T
    private let window: Window

    public init(team: T, window: Window) { self.team = team; self.window = window }

    public func evaluate(board: Board<T>) -> Int {
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
