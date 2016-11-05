import TicTacToe
import Vapor



var lastBoard: Board<Bool>?
var nextMove: ((Int) -> Void)?

let message = (
   boardNotAvailable: "Sorry, the board is not available yet.",
   notYourTurn: "Sorry, it's not your turn.",
   success: "Success!"
)


func encode(_ b: Bool?) -> String? {
    return b.map { $0 ? "X" : "O" }
}



struct UI: UserInterface {
    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        lastBoard = board
        nextMove = move
    }

    func end(board: Board<Bool>) {
        lastBoard = board
    }
}


let drop = Droplet()
let ui = UI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let simulation = Simulation(ui: ui, players: players, args: CommandLine.arguments)


drop.get("board") { _ in
    guard let board = lastBoard else { return message.boardNotAvailable }
    return try JSON(node: board.map(encode)).makeBytes().string
}

drop.get("move", Int.self) { _, param in
    guard let move = nextMove else { return message.notYourTurn }
    guard let board = lastBoard else { return message.boardNotAvailable }

    move(param)
    nextMove = nil
    return message.success
}


simulation.start()
drop.run()
