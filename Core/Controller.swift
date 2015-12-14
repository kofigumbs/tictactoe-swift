import UI

public class Controller<U: Player> {

    public var isActive: Bool { return !Game(board: board).isOver() }
    public var board: Board<U.T>

    private var players: [U]

    public init(window: Window, configuration: Configuration<U>) {
        players = [configuration.players.first, configuration.players.second]
        board = configuration.board
    }

    public func proceed() {
        let player = players.first!
        board = board.markAt(player.evaluate(board), with: player.team)
        players = players.reverse()
    }
}
