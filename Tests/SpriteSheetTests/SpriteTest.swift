import XCTest
import SpriteSheet
@testable import TicTacToe

extension OneByOne: Sheet {}
extension LargerSprites: Sheet {}

class SpriteTest: XCTestCase {

    func testOneByOneSheet() {
        let board = Board(dimmension: 3)
            .marked(at: 0, with: true)
            .marked(at: 8, with: false)
            .marked(at: 4, with: true)

        let grid: [[UnicodeScalar]] = [
            ["x", "|", " ", "|", " "],
            ["-", "+", "-", "+", "-"],
            [" ", "|", "x", "|", " "],
            ["-", "+", "-", "+", "-"],
            [" ", "|", " ", "|", "o"]
        ]

        grid === Sprite(sheet: OneByOne()).grid(board: board)
    }

    func testLargerSprites() {
        let board = Board(dimmension: 2)
            .marked(at: 0, with: true)
            .marked(at: 3, with: false)

        let grid: [[UnicodeScalar]] = [
            ["T", "R", "V", "E", "E", "M"],
            ["U", "E", "R", "T", "P", "T"],
            ["H", "O", "J", "U", "H", "O"],
            ["R", "I", "N", "C", "R", "I"],
            ["E", "M", "V", "E", "F", "A"],
            ["P", "T", "R", "T", "L", "S"]
        ]

        grid === Sprite(sheet: LargerSprites()).grid(board: board)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SpriteTest) -> () throws -> Void)] {
        return [
            ("testOneByOneSheet", testOneByOneSheet),
            ("testLargerSprites", testLargerSprites)
        ]
    }
#endif

}
