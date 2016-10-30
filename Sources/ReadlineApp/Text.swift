struct Text {

    let prompt = "\n  <YOUR TURN>  "
    let horizontalLine = "\n\n    -----------\n\n"
    let veriticalLine = "|"

    func padded(_ char: Character?) -> String {
        return " \(char ?? " ") "
    }

    func indented(_ string: String) -> String {
        return "    " + string
    }

    func separated(_ string: String) -> String {
        return "\n\n" + string
    }

    func marker(for team: Bool?) -> Character? {
        return team.map { $0 ? "X" : "O" }
    }

}
