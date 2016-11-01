import Core

class StubPlayer: Player {

    let team: String
    var moves: [Int]

    init(team: String, moves: [Int] = []) {
        self.team = team
        self.moves = moves
    }

    func evaluate(board: Board<String>, move: (Int) -> Void) {
        moves.popLast().map { move($0) }
    }

}
