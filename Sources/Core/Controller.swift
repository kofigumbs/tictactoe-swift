public class Controller<U: Player, V: Player, W: Window> where U.T == V.T, U.T == W.T {

    public var isActive: Bool { return !Game(board: board).isOver() }
    public var board: Board<U.T>

    private var players: (U, V)
    private let window: W
    private var turn: Bool

    public init(window: W, players: (U, V), args: [String]) {
        self.board = Board(dimmension: 3)
        self.players = players
        self.window = window
        self.turn = !args.contains("--second")
    }

    public func proceed() {
        takeTurn()
        if Game(board: board).isOver() {
            window.draw(grid: board.grid)
        }
    }

    private func takeTurn() {
        turn ? takeTurn(with: players.0) : takeTurn(with: players.1)
        turn = !turn
    }

    private func takeTurn<X: Player>(with player: X) where X.T == U.T {
        let move = player.evaluate(board: board)
        board = board.marked(at: move, with: player.team)
    }

}

