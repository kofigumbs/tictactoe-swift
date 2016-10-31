public class Controller<P1: Player, P2: Player, Win: Window>
        where Win.Mark == P1.Mark, Win.Mark == P2.Mark {

    typealias Mark = Win.Mark

    public var board: Board<Mark>
    public var isActive: Bool {
        return !Game(board: board).isOver
    }

    private var players: (P1, P2)
    private var p1Turn: Bool
    private let window: Win

    public init(window: Win, players: (P1, P2), args: [String]) {
        self.board = Board(dimmension: 3)
        self.players = players
        self.window = window
        self.p1Turn = !args.contains("--second")
    }

    public func proceed() {
        let board = takeTurn()
        if Game(board: board).isOver {
            window.draw(board: board)
        }

        self.p1Turn = !p1Turn
        self.board = board
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
