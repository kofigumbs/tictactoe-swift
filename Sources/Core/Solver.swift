public class Solver<T: Hashable>: Player {

    private typealias MoveScore = (move: Int, score: Int)

    public let team: T
    private let opponent: T
    private var move: Int = -1
    private var maxRecursionDepth: Int = 6

    public init(team: T, opponent: T) { self.team = team; self.opponent = opponent }

    public func evaluate(board: Board<T>) -> Int {
        return shortcutOptimization(on: board) ??
            calculateBestMove(on: board, depth: maxRecursionDepth)
    }

    private func shortcutOptimization(on board: Board<T>) -> Int? {
        if board.isEmpty { return 0 }
        if let center = takeCenter(on: board) { return center }
        return nil
    }

    private func takeCenter(on board: Board<T>) -> Int? {
        let onlyOneMoveMade = board.availableSpaces().count == board.count - 1
        let boardHasCenter = board.dimmension % 2 == 1
        let center = board.count / 2
        let centerIsAvailable = board[center] == nil
        return onlyOneMoveMade && boardHasCenter && centerIsAvailable ? center : nil
    }

    private func calculateBestMove(on board: Board<T>, depth: Int) -> Int {
        let _ = bestScore(for: self.team, vs: self.opponent, board: board, depth: depth)
        return move
    }

    private func bestScore(for team: T, vs opponent: T, board: Board<T>, depth: Int) -> Int {
        return escapeBestScore(board: board, depth: depth) ??
            recurBestScore(for: team, vs: opponent, board: board, depth: depth)
    }

    private func escapeBestScore(board: Board<T>, depth: Int) -> Int? {
        let game = Game(board: board)

        if game.winner() == self.team {
            return depth + 1
        } else if game.winner() == self.opponent {
            return -(depth + 1)
        } else if game.isOver() || depth == 0 {
            return 0
        } else {
            return nil
        }
    }

    private func recurBestScore(for team: T, vs opponent: T, board: Board<T>, depth: Int) -> Int {
        let best: MoveScore = board.availableSpaces()
            .map { (move: $0, board: board.marked(at: $0, with: team), depth: depth - 1) }
            .map { stepBestMoveScore(for: opponent, vs: team, board: $0.board, move: $0.move, depth: $0.depth) }
            .max { team == self.team ? $0.score < $1.score : $0.score > $1.score }!

        move = best.move
        return best.score
    }

    private func stepBestMoveScore(for team: T, vs opponent: T, board: Board<T>, move: Int, depth: Int) -> MoveScore {
        let score = bestScore(for: team, vs: opponent, board: board, depth: depth)
        let result = (move, score)
        return result
    }
}

