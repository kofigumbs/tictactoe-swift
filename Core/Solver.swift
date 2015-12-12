class Solver<T: Hashable> {

    typealias MoveScore = (move: Int?, score: Int)

    let teams: (target: T, opponent: T)

    init(team: T, opponent: T) { self.teams = (team, opponent) }

    func solve(board: Board<T>) -> Int? {
        return bestMoveScoreFor(teams.target, vs: teams.opponent, board: board, depth: 0, seed: nil).move
    }

    private func bestMoveScoreFor(target: T, vs opponent: T, board: Board<T>, depth: Int, seed: Int?) -> MoveScore {
        let game = Game(board: board)
        if game.isOver() {
            return escapeBestMoveScoreFor(game, depth: depth, seed: seed)
        } else {
            return recurBestMoveScoreFor(target, vs: opponent, board: board, depth: depth, seed: seed)
        }
    }

    private func escapeBestMoveScoreFor(game: Game<T>, depth: Int, seed: Int?) -> MoveScore {
        return (seed, score(game, depth: depth))
    }

    private func score(game: Game<T>, depth: Int) -> Int {
        let TOP_SCORE = game.board.count

        switch game.winner() {
        case teams.target?: return TOP_SCORE - depth
        case teams.opponent?: return depth - TOP_SCORE
        default: return 0
        }
    }

    private func recurBestMoveScoreFor(target: T, vs opponent: T, board: Board<T>, depth: Int, seed: Int?) -> MoveScore {
        return board.availableSpaces()
            .map({ (seed: $0, board: board.markAt($0, with: target), depth: depth + 1) })
            .map({ (move: $0.seed, score: bestMoveScoreFor(
                opponent, vs: target, board: $0.board, depth: $0.depth, seed: $0.seed).score) })
            .maxElement({ target == teams.target ? $0.score < $1.score : $0.score > $1.score })!
    }

}
