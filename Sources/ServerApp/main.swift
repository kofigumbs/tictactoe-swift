import TicTacToe
import Vapor


let drop = Droplet()
let ui = ServerUI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let simulation = Simulation(ui: ui, players: players, args: CommandLine.arguments)
let message = (
   boardNotAvailable: "Sorry, the board is not available yet.",
   notYourTurn: "Sorry, it's not your turn.",
   success: "Success!"
)

func encode(bool: Bool?) -> String? {
    return bool.map { $0 ? "X" : "O" }
}

drop.get("board") { _ in
    guard let board = ui.lastBoard else { return message.boardNotAvailable }
    return try JSON(node: board.map(encode)).makeBytes().string
}

drop.get("move", Int.self) { _, param in
    guard ui.waitingForMove else { return message.notYourTurn }
    ui.move(param)
    return message.success
}


simulation.start()
drop.run()
