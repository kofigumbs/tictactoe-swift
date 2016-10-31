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
        self.board = takeTurn()
        self.state = update()
    }

    private func takeTurn() -> Board<Mark> {
        switch state {
        case .p0Turn:
            return takeTurn(with: players.0)
        case .p1Turn:
            return takeTurn(with: players.1)
        case .finished:
            return board
        }
    }

    private func takeTurn<P: Player>(with player: P) -> Board<Mark>
            where P.Mark == Mark {
        let move = player.evaluate(board: board)
        return board.marked(at: move, with: player.team)
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
