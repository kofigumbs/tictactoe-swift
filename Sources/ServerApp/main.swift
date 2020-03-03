import TicTacToe
import Vapor


let drop = try Droplet()
let solver = Solver(team: false, opponent: true)

drop.socket("game") { _, ws in
    let ui = ServerUI { try ws.send(opCode: .text, with: $0) }
    let human = Human(team: true, ui: ui)
    let simulation = Simulation(ui: ui, players: (human, solver), args: [])

    ws.onText = { ws, text in
        let json = try JSON(bytes: Array(text.utf8))

        if let move = json.object?["move"]?.int {
            ui.send(move: move)
        }
    }

    simulation.play()
}

try drop.run()
