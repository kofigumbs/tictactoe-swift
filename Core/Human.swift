import UI

class Human<T: Hashable>: Player {

    let window: Window
    let team: T

    init(team: T, window: Window) { self.team = team; self.window = window }

    func evaluate(board: Board<T>) -> Int {
        var attempt: Int
        repeat {
            attempt = promptForMove()
        } while !board.availableSpaces().contains(attempt)
        return attempt
    }

    func promptForMove() -> Int {
        var move: Int?
        repeat {
            move = Int(window.promptUser("Your turn"))
        } while move == nil
        return move!
    }

}
