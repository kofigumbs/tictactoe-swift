import TicTacToe
import Vapor



var lastBoard: Board<Bool>?
var nextMove: ((Int) -> Void)?

let message = (
   boardNotAvailable: "Sorry, the board is not available yet.",
   notYourTurn: "Sorry, it's not your turn.",
   occupied: "Sorry, that space is occupied.",
   success: "Success!"
)


func encode(_ b: Bool?) -> String? {
    return b.map { $0 ? "X" : "O" }
}



struct UI: UserInterface {
    func prompt(on board: Board<Bool>, move: @escaping (Int) -> Void) {
        lastBoard = board
        nextMove = move
    }
}


let drop = Droplet()
let players = (Human(team: true, ui: UI()), Solver(team: false, opponent: true))
let simulation = Simulation(players: players, args: CommandLine.arguments)


drop.get("board") { _ in
    guard let board = lastBoard else { return message.boardNotAvailable }
    return try JSON(node: board.map(encode)).makeBytes().string
}

drop.get("move", Int.self) { _, param in
    guard let move = nextMove else { return message.notYourTurn }
    guard let board = lastBoard else { return message.boardNotAvailable }

    if board.availableSpaces().contains(param) {
        move(param)
        nextMove = nil
        return message.success
    } else {
        return message.occupied
    }
}


simulation.start()
drop.run()
