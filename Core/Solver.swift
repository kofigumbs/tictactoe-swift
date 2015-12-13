class Solver<T: Hashable>: Player {

    private typealias MoveScore = (move: Int, score: Int)

    private var cache: [Board<T>: MoveScore] = Dictionary()
    private var move: Int = -1
    private let opponent: T
    let team: T

    init(team: T, opponent: T) { self.team = team; self.opponent = opponent }

    func evaluate(board: Board<T>) -> Int {
        return shortcutOptimization(board) ??
            calculateBestMove(board)
    }

    func shortcutOptimization(board: Board<T>) -> Int? {
        return board.isEmpty ? 0 : nil
    }

    private func calculateBestMove(board: Board<T>) -> Int {
        bestScoreFor(self.team, vs: self.opponent, board: board)
        return move
    }

    private func bestScoreFor(team: T, vs opponent: T, board: Board<T>) -> Int {
        return escapeBestScoreFor(board) ??
            recurBestScoreFor(team, vs: opponent, board: board)
    }

    private func escapeBestScoreFor(board: Board<T>) -> Int? {
        return cachedScoreFor(board) ??
            finalScoreFor(board)
    }

    private func cachedScoreFor(board: Board<T>) -> Int? {
        return cache[board].map({ move = $0.move; return $0.score })
    }

    private func finalScoreFor(board: Board<T>) -> Int? {
        let game = Game(board: board)

        if game.winner() == self.team {
            return board.availableSpaces().count
        } else if game.winner() == self.opponent {
            return -board.availableSpaces().count
        } else if game.isOver() {
            return 0
        } else {
            return nil
        }
    }

    private func recurBestScoreFor(team: T, vs opponent: T, board: Board<T>) -> Int {
        let best: MoveScore = board.availableSpaces()
            .map({ (move: $0, board: board.markAt($0, with: team)) })
            .map({ cacheBestMoveScoreFor(opponent, vs: team, board: $0.board, move: $0.move) })
            .maxElement({ team == self.team ? $0.score < $1.score : $0.score > $1.score})!

        move = best.move
        return best.score
    }

    private func cacheBestMoveScoreFor(team: T, vs opponent: T, board: Board<T>, move: Int) -> MoveScore {
        let score = bestScoreFor(team, vs: opponent, board: board)
        let result = (move, score)
        cache[board] = result
        return result
    }
}
