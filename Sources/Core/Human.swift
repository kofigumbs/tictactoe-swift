public class Human<UI: UserInterface>: Player {

    public let team: UI.Mark
    private let ui: UI

    public init(team: UI.Mark, ui: UI) {
        self.team = team
        self.ui = ui
    }

    public func evaluate(board: Board<UI.Mark>) -> Int {
        return ui.promptMove(on: board)
    }

}
