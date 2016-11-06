import TicTacToe

struct ReadlineUI: UserInterface {

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)

        var input: Int? = nil
        repeat {
            print(Text.prompt, terminator: "")
            input = readLine().flatMap { Int($0) }
        } while input == nil

        move(input!)
    }

    func end(board: Board<Bool>) {
        draw(board: board)
    }

    private func draw(board: Board<Bool>) {
        let rows = createRows(board: board)
        let grid = formatted(rows: rows)

        print(Text.separated(grid))
    }

    private func formatted(rows: [String]) -> String {
        return rows
            .map(Text.indented)
            .joined(separator: Text.horizontalLine)
    }

    private func createRows(board: Board<Bool>) -> [String] {
        let bounds = 0 ..< board.dimmension
        return bounds.flatMap { createRow(board: board, row: $0) }
    }

    private func createRow(board: Board<Bool>, row: Int) -> String {
        let bounds = 0 ..< board.dimmension
        return bounds
            .map { col in createMarker(on: board, row: row, col: col) }
            .map(Text.padded)
            .joined(separator: Text.veriticalLine)
    }

    private func createMarker(on board: Board<Bool>, row: Int, col: Int) -> Character? {
        return board[row * board.dimmension + col].flatMap(Text.marker)
    }

}
