class Solver<T: Hashable> {

    typealias MoveScore = (move: Int?, score: Int)

    private var cache: [Board<T>: MoveScore] = Dictionary()
    private var move: Int?

    private let teams: (target: T, opponent: T)

    init(team: T, opponent: T) { self.teams = (team, opponent) }

    func solve(board: Board<T>) -> Int? {
        return shortcutOptimization(board) ??
            calculateBestMove(board)
    }

    func shortcutOptimization(board: Board<T>) -> Int? {
        return board.isEmpty ? 0 : nil
    }

    private func calculateBestMove(board: Board<T>) -> Int? {
        bestScoreFor(teams.target, vs: teams.opponent, board: board)
        return move
    }

    private func bestScoreFor(target: T, vs opponent: T, board: Board<T>) -> Int {
        return escapeBestScoreFor(board) ??
            recurBestScoreFor(target, vs: opponent, board: board)
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

        if game.winner() == teams.target {
            return board.availableSpaces().count
        } else if game.winner() == teams.opponent {
            return -board.availableSpaces().count
        } else if game.isOver() {
            return 0
        } else {
            return nil
        }
    }

    private func recurBestScoreFor(target: T, vs opponent: T, board: Board<T>) -> Int {
        let best: MoveScore = board.availableSpaces()
            .map({ (move: $0, board: board.markAt($0, with: target)) })
            .map({ cacheBestMoveScoreFor(opponent, vs: target, board: $0.board, move: $0.move) })
            .maxElement({ target == teams.target ? $0.score < $1.score : $0.score > $1.score})!

        move = best.move
        return best.score
    }

    private func cacheBestMoveScoreFor(target: T, vs opponent: T, board: Board<T>, move: Int?) -> MoveScore {
        let score = bestScoreFor(target, vs: opponent, board: board)
        let result = (move, score)
        cache[board] = result
        return result
    }
}
