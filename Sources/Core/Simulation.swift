public class Simulation<P0: Player, P1: Player> where P0.Mark == P1.Mark {

    typealias Mark = P0.Mark

    public var board: Board<Mark>
    public var isActive: Bool {
        return state != .finished
    }

    private let players: (P0, P1)
    private var state: State

    public init(players: (P0, P1), args: [String]) {
        self.board = Board(dimmension: 3)
        self.state = args.contains("--second") ? .p1Turn : .p0Turn
        self.players = players
    }

    public func proceed() {
        takeTurn()
        self.state = update()
    }

    private func takeTurn() {
        switch state {
        case .p0Turn:
            takeTurn(with: players.0)
            break
        case .p1Turn:
            takeTurn(with: players.1)
            break
        case .finished:
            break
        }
    }

    private func takeTurn<P: Player>(with player: P)
            where P.Mark == Mark {
        player.evaluate(board: board) { move in
            self.board = board.marked(at: move, with: player.team)
        }
    }

    private func update() -> State {
        switch (Game(board: board).isOver, state) {
        case (true, _):
            fallthrough
        case (false, .finished):
            return .finished
        case (false, .p0Turn):
            return .p1Turn
        case (false, .p1Turn):
            return .p0Turn
        }
    }

}

public enum State {
    case p0Turn, p1Turn, finished
}
