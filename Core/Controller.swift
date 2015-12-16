import UI

public class Controller<U: Player, V: Player, W: Window where U.T == V.T, U.T == W.T> {

    public var isActive: Bool { return !Game(board: board).isOver() }
    public var board: Board<U.T>

    private var players: (U, V)
    private let window: W
    private var turn: Bool

    public init(window: W, players: (U, V), args: [String]) {
        self.board = Board(dimmension: 3)
        self.turn = !args.contains("--second")
        self.players = players
        self.window = window
    }

    public func proceed() {
        takeTurn()
        if Game(board: board).isOver() {
            window.drawGrid(board.grid)
        }
    }

    private func takeTurn() {
        turn ? takeTurnWith(players.0) : takeTurnWith(players.1)
        turn = !turn
    }

    private func takeTurnWith<X: Player where X.T == U.T>(player: X) {
        let move = player.evaluate(board)
        board = board.markAt(move, with: player.team)
    }

}

