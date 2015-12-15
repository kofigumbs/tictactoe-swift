public class Solver<T: Hashable>: Player {

    private typealias MoveScore = (move: Int, score: Int)

    public let team: T
    private let opponent: T
    private var move: Int = -1
    private var maxRecursionDepth: Int = -1
    private var cache: [Board<T>: MoveScore] = Dictionary()

    public init(team: T, opponent: T) { self.team = team; self.opponent = opponent }

    public func evaluate(board: Board<T>) -> Int {
        maxRecursionDepth = calculateMaxRecursionDepth(board)
        return shortcutOptimization(board) ??
            calculateBestMove(board, depth: maxRecursionDepth)
    }

    private func calculateMaxRecursionDepth(board: Board<T>) -> Int {
        let dx = -2, y0 = 12
        let y = dx * board.dimmension + y0
        return y > 0 ? y : 1
    }

    private func shortcutOptimization(board: Board<T>) -> Int? {
        return board.isEmpty ? 0 : nil
    }

    private func calculateBestMove(board: Board<T>, depth: Int) -> Int {
        bestScoreFor(self.team, vs: self.opponent, board: board, depth: depth)
        return move
    }

    private func bestScoreFor(team: T, vs opponent: T, board: Board<T>, depth: Int) -> Int {
        return escapeBestScoreFor(board, depth: depth) ??
            recurBestScoreFor(team, vs: opponent, board: board, depth: depth)
    }

    private func escapeBestScoreFor(board: Board<T>, depth: Int) -> Int? {
        return cachedScoreFor(board) ??
            finalScoreFor(board, depth: depth)
    }

    private func cachedScoreFor(board: Board<T>) -> Int? {
        return cache[board].map({ move = $0.move; return $0.score })
    }

    private func finalScoreFor(board: Board<T>, depth: Int) -> Int? {
        let game = Game(board: board)

        if game.winner() == self.team {
            return board.availableSpaces().count
        } else if game.winner() == self.opponent {
            return -board.availableSpaces().count
        } else if game.isOver() || depth == 0 {
            return 0
        } else {
            return nil
        }
    }

    private func recurBestScoreFor(team: T, vs opponent: T, board: Board<T>, depth: Int) -> Int {
        let best: MoveScore = board.availableSpaces()
            .map({ (move: $0, board: board.markAt($0, with: team), depth: depth - 1) })
            .map({ cacheBestMoveScoreFor(opponent, vs: team, board: $0.board, move: $0.move, depth: $0.depth) })
            .maxElement({ team == self.team ? $0.score < $1.score : $0.score > $1.score})!

        move = best.move
        return best.score
    }

    private func cacheBestMoveScoreFor(team: T, vs opponent: T, board: Board<T>, move: Int, depth: Int) -> MoveScore {
        let score = bestScoreFor(team, vs: opponent, board: board, depth: depth)
        let result = (move, score)
        cache[board] = result
        return result
    }
}

