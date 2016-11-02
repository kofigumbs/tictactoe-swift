import TicTacToe

struct ReadlineUI: UserInterface {
    let text = Text()

    func prompt(on board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)

        var input: Int? = nil
        repeat {
            print(text.prompt, terminator: "")
            input = readLine().flatMap { Int($0) }
        } while input == nil || !board.availableSpaces().contains(input!)

        move(input!)
    }

    private func draw(board: Board<Bool>) {
        let rows = createRows(board: board)
        let board = formatted(rows: rows)

        print(text.separated(board))
    }

    private func formatted(rows: [String]) -> String {
        return rows
            .map(text.indented)
            .joined(separator: text.horizontalLine)
    }

    private func createRows(board: Board<Bool>) -> [String] {
        let bounds = 0 ..< board.dimmension
        return bounds.flatMap { createRow(board: board, row: $0) }
    }

    private func createRow(board: Board<Bool>, row: Int) -> String {
        let bounds = 0 ..< board.dimmension
        return bounds
            .map { col in createMarker(on: board, row: row, col: col) }
            .map(text.padded)
            .joined(separator: text.veriticalLine)
    }

    private func createMarker(on board: Board<Bool>, row: Int, col: Int) -> Character? {
        return board[row * board.dimmension + col].flatMap(text.marker)
    }

}
