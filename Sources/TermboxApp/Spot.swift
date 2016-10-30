import Termbox

enum Spot {

    case taken(team: Bool, selected: Bool)
    case empty(selected: Bool)
    case verticalDivider
    case horizontalDivider

    func present() -> Cell {
        switch self {
        case .taken(let team, let selected):
            return takenCell(team: team, selected: selected)
        case .empty(let selected):
            return emptyCell(selected: selected)
        case .verticalDivider:
            return verticalDividerCell()
        case .horizontalDivider:
            return horizontalDividerCell()
        }
    }

    func takenCell(team: Bool, selected: Bool) -> Cell {
        switch (team, selected) {
        case (true, false):
            return (character: " ", foreground: .none, background: .cyan)
        case (false, false):
            return (character: " ", foreground: .none, background: .blue)
        default:
            return (character: " ", foreground: .none, background: .black)
        }
    }

    func emptyCell(selected: Bool) -> Cell {
        if selected {
            return (character: " ", foreground: .none, background: .white)
        } else {
            return (character: " ", foreground: .none, background: .none)
        }
    }

    func verticalDividerCell() -> Cell {
        return (character: "|", foreground: .white, background: .none)
    }

    func horizontalDividerCell() -> Cell {
        return (character: "-", foreground: .white, background: .none)
    }

}
