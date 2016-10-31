import Core

let ui = ReadlineUI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let controller = Controller(players: players, args: CommandLine.arguments)

while controller.isActive {
    controller.proceed()
}
