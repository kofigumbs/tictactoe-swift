enum Text {

    static let prompt = "\n  <YOUR TURN>  "
    static let horizontalLine = "\n\n    -----------\n\n"
    static let veriticalLine = "|"

    static func padded(_ char: Character?) -> String {
        return " \(char ?? " ") "
    }

    static func indented(_ string: String) -> String {
        return "    " + string
    }

    static func separated(_ string: String) -> String {
        return "\n\n" + string
    }

    static func marker(for team: Bool?) -> Character? {
        return team.map { $0 ? "X" : "O" }
    }

}
