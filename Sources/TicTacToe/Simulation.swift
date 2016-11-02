public struct Simulation<P0: Player, P1: Player> where P0.Mark == P1.Mark {

    typealias Mark = P0.Mark

    private let players: (P0, P1)
    private let callbacks: [State: () -> ()]
    private var state: State
    private var board: Board<Mark>

    private init(players: (P0, P1), state: State, board: Board<Mark>, callbacks: [State: () -> ()]) {
        self.players = players
        self.state = state
        self.board = board
        self.callbacks = callbacks
    }

    public init(players: (P0, P1), args: [String]) {
        let board = Board<Mark>(dimmension: 3)
        let state: State = args.contains("--second") ? .waitingForP1 : .waitingForP0
        self.init(players: players, state: state, board: board, callbacks: [:])
    }

    public func on(_ state: State, then: @escaping () -> ()) -> Simulation {
        var callbacks = self.callbacks
        callbacks[state] = then
        return Simulation(players: self.players, state: self.state, board: self.board, callbacks: callbacks)
    }

    public func start() {
        callbacks[state].map { $0() }

        switch state {
        case .waitingForP0:
            evaluate(with: players.0, next: .p0Played)
        case .p0Played:
            proceed(next: .waitingForP1)
        case .waitingForP1:
            evaluate(with: players.1, next: .p1Played)
        case .p1Played:
            proceed(next: .waitingForP0)
        case .finished:
            break
        }
    }

    private func evaluate<P: Player>(with player: P, next: State) where P.Mark == Mark {
        player.evaluate(board: board) { move in
            self.simulate(next: next, board: self.board.marked(at: move, with: player.team))
        }
    }

    private func proceed(next: State) {
        simulate(next: Game(board: board).isOver ? .finished : next, board: board)
    }

    private func simulate(next state: State, board: Board<Mark>) {
        Simulation(players: players, state: state, board: board, callbacks: callbacks)
            .start()
    }

}

public enum State {
    case waitingForP0, p0Played, waitingForP1, p1Played, finished
}
