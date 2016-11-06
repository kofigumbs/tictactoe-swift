import TicTacToe
import SpriteSheet


struct ReadlineUI: UserInterface {

    let sprite = Sprite(sheet: ReadlineSprites())

    func prompt(board: Board<Bool>, move: @escaping (Int) -> Void) {
        draw(board: board)

        var input: Int? = nil
        repeat {
            print("\n>> ", terminator: "")
            input = readLine().flatMap { Int($0) }
        } while input == nil

        move(input!)
    }

    func end(board: Board<Bool>) {
        draw(board: board)
    }

    private func draw(board: Board<Bool>) {
        for line in sprite.grid(board: board) {
            line.forEach { print($0, terminator: "") }
            print("")
        }
    }

}
