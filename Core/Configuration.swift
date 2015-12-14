public struct Configuration<U: Player> {

    public let players: (first: U, second: U)

    public init(players: (U, U), args: [String]) {
        let (one, two) = players
        self.players = args.contains("--reverse") ? (two, one) : (one, two)
    }

}

