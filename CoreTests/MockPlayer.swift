import Core

class MockPlayer: Player {

    let team: String

    init(team: String) { self.team = team }

    func evaluate(board: Board<String>) -> Int { return -1 }

}

