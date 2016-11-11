import TicTacToe
import SpriteSheet


struct ReadlineUI: UserInterface {

    let sprite = Sprite(sheet: ReadlineSprites())

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)

        var input: Int? = nil
        repeat {
            print("\n>> [0-\(max(board))]: ", terminator: "")
            input = readLine().flatMap { Int($0) }
            print("\n")
        } while input == nil

        move(input!)
    }

    func end(board: Board<Bool>) {
        draw(board: board)
    }

    private func draw(board: Board<Bool>) {
        for line in sprite.grid(board: board) {
            print(line.reduce("") { $0 + String($1) })
        }
    }

    private func max(_ board: Board<Bool>) -> Int {
        return board.dimmension * board.dimmension - 1
    }

}
