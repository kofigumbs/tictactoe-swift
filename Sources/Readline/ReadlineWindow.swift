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

    func draw(grid: Grid<T>) {
        let rows = createRows(grid: grid)
        let board = formatted(rows: rows)

        print("\n\n" + board)
    }

    private func formatted(rows: [String]) -> String {
        return rows.map { "    \($0)" }.joined(separator: "\n\n    -----------\n\n")
    }

    private func createRows(grid: Grid<T>) -> [String] {
        let bounds = 0 ..< grid.dimmension
        return bounds.flatMap { createRow(grid: grid, row: $0) }
    }

    private func createRow(grid: Grid<T>, row: Int) -> String {
        let bounds = 0 ..< grid.dimmension
        return bounds.map { col in createMarker(on: grid, row: row, col: col) }.joined(separator: "|")
    }

    private func createMarker(on grid: Grid<T>, row: Int, col: Int) -> String {
        guard let player = grid[row * grid.dimmension + col] else { return "   " }
        let marker = markers[player] ?? nextMarker()

        markers[player] = marker

        return marker
    }

    private func nextMarker() -> String {
        return markers.contains { $0.1 == " X " } ? " O " : " X "
    }
}
