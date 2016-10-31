public class Simulation<P1: Player, P2: Player> where P1.Mark == P2.Mark {

    typealias Mark = P1.Mark

    public var board: Board<Mark>
    public var isActive: Bool {
        return !Game(board: board).isOver
    }

    private var players: (P1, P2)
    private var p1Turn: Bool

    public init(players: (P1, P2), args: [String]) {
        self.board = Board(dimmension: 3)
        self.players = players
        self.p1Turn = !args.contains("--second")
    }

    public func proceed() {
        self.board = takeTurn()
        self.p1Turn = !p1Turn
    }

    private func takeTurn() -> Board<Mark> {
        return p1Turn ? takeTurn(with: players.0) : takeTurn(with: players.1)
    }

    private func takeTurn<P: Player>(with player: P) -> Board<Mark>
            where P.Mark == Mark {
        let move = player.evaluate(board: board)
        return board.marked(at: move, with: player.team)
    }

}
