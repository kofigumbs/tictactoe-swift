import TicTacToe
import CTermbox

let ui = TermboxUI()
let players = (Human(team: true, ui: ui), Solver(team: false, opponent: true))
let simulation = Simulation(players: players, args: CommandLine.arguments)

simulation.start()
