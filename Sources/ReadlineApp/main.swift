import Core

let ui = ReadlineUI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let simulation = Simulation(players: players, args: CommandLine.arguments)

while simulation.isActive {
    simulation.proceed()
}
