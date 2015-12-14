public struct Configuration<U: Player> {

    public let players: (first: U, second: U)
    public let board: Board<U.T>

    public init(players: (U, U), args: [String]) {
        let (one, two) = players
        self.players = args.contains("--reverse") ? (two, one) : (one, two)
        self.board = args.contains("--four") ? Board(dimmension: 4) : Board(dimmension: 3)
    }

}

