import Core
import CTermbox

let window = TermboxWindow<Bool>()
let players = (Human(team: true, window: window), Solver(team: false, opponent: true))
let controller = Controller(window: window, players: players, args: CommandLine.arguments)

while controller.isActive { controller.proceed() }
