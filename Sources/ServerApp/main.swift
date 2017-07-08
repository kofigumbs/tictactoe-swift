import TicTacToe
import Vapor


let drop = Droplet()
let solver = Solver(team: false, opponent: true)

drop.get("/") { _ in
    return try drop.view.make("index.html")
}

drop.socket("game") { _, ws in
    let ui = ServerUI(update: ws.send)
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

drop.run()
