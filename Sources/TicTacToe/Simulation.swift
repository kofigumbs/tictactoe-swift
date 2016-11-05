public struct Simulation<UI: UserInterface, P0: Player, P1: Player> where UI.Mark == P0.Mark, UI.Mark == P1.Mark {

    typealias Mark = UI.Mark

    private let ui: UI
    private let players: (P0, P1)
    private let state: State
    private let board: Board<Mark>

    private init(ui: UI, players: (P0, P1), state: State, board: Board<Mark>) {
        self.ui = ui
        self.players = players
        self.state = state
        self.board = board
    }

    public init(ui: UI, players: (P0, P1), args: [String]) {
        let state = State.initial(args: args)
        let board = Board<Mark>(dimmension: 3)
        self.init(ui: ui, players: players, state: state, board: board)
    }

    public func start() {
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
            ui.end(board: board)
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
        Simulation(ui: ui, players: players, state: state, board: board).start()
    }

}

private enum State {
    case waitingForP0, p0Played, waitingForP1, p1Played, finished

    static func initial(args: [String]) -> State {
        return args.contains("--second") ? .waitingForP1 : .waitingForP0
    }

}
