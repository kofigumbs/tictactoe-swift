import UI

public class Controller<U: Player> {

    public var isActive: Bool { return !Game(board: board).isOver() }
    public var board: Board<U.T>

    private var players: [U]
    private let window: Window

    public init(window: Window, configuration: Configuration<U>) {
        self.players = [configuration.players.first, configuration.players.second]
        self.board = configuration.board
        self.window = window
    }

    public func proceed() {
        window.drawGrid(board.grid)
        update()
    }

    private func update() {
        let player = players.first!
        let move = player.evaluate(board)
        board = board.markAt(move, with: player.team)
        players = players.reverse()
    }
}
