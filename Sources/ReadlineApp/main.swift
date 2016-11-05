import TicTacToe

let ui = ReadlineUI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let simulation = Simulation(ui: ui, players: players, args: CommandLine.arguments)

simulation.start()
