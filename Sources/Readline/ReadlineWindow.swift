import Core

class ReadlineWindow<T: Hashable>: Window {

    var markers = [T:String]()

    func promptUserForIndex() -> Int {
        repeat {
            print("\n  <YOUR TURN>  ", terminator: "")
            if let move = readLine().flatMap({ Int($0) }) {
                return move
            }
        } while true
    }

    func draw(board: Board<T>) {
        let rows = createRows(board: board)
        let board = formatted(rows: rows)

        print("\n\n" + board)
    }

    private func formatted(rows: [String]) -> String {
        return rows.map { "    \($0)" }.joined(separator: "\n\n    -----------\n\n")
    }

    private func createRows(board: Board<T>) -> [String] {
        let bounds = 0 ..< board.dimmension
        return bounds.flatMap { createRow(board: board, row: $0) }
    }

    private func createRow(board: Board<T>, row: Int) -> String {
        let bounds = 0 ..< board.dimmension
        return bounds.map { col in createMarker(on: board, row: row, col: col) }.joined(separator: "|")
    }

    private func createMarker(on board: Board<T>, row: Int, col: Int) -> String {
        guard let player = board[row * board.dimmension + col] else { return "   " }
        let marker = markers[player] ?? nextMarker()

        markers[player] = marker

        return marker
    }

    private func nextMarker() -> String {
        return markers.contains { $0.1 == " X " } ? " O " : " X "
    }
}
