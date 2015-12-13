import Core
import UI
import TermboxAdapter

let window = TermboxWindow<Bool>()
let human = Human(team: true, window: window)
let solver = Solver(team: false, opponent: true)
let controller = Controller(window: window, players: (human, solver), args: Process.arguments)

while controller.isActive { controller.proceed() }

window.destroy()

