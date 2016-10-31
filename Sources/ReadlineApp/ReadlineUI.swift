import Core

struct ReadlineUI: UserInterface {
    let text = Text()

    func promptMove(on board: Board<Bool>) -> Int {
        draw(board: board)
        var move: Int? = nil
        repeat {
            print(text.prompt, terminator: "")
            move = readLine().flatMap { Int($0) }
        } while move == nil || !board.availableSpaces().contains(move!)
        return move!
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
