import UI

public class Controller<U: Player, V: Player, W: Window where U.T == V.T, U.T == W.T> {

    public var isActive: Bool { return !Game(board: board).isOver() }
    public var board: Board<U.T>

    private var players: (U, V)
    private let window: W
    private var turn: Bool

    public init(window: W, players: (U, V), args: [String]) {
        let dimmension = args.contains("--four") ? 4 : 3

        self.board = Board(dimmension: dimmension)
        self.turn = !args.contains("--reverse")
        self.players = players
        self.window = window
    }

    public func proceed() {
        window.drawGrid(board.grid)
        takeTurn()
    }

    private func takeTurn() {
        turn ? takeTurn(players.0) : takeTurn(players.1)
        turn = !turn
    }

    private func takeTurn<X: Player where X.T == U.T>(player: X) {
        let move = player.evaluate(board)
        board = board.markAt(move, with: player.team)
    }

}

