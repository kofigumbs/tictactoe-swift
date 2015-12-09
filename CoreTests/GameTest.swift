import XCTest
import UI
@testable import Core

class GameTest: XCTestCase {

    func testNewGameIsNotOver() {
        let board: Grid<Character> = Grid(dimmension: 3)

        XCTAssertFalse(gameIsOver(board))
    }

    func testFullGameIsNotOver() {
        let board: Grid<Character> = Grid(dimmension: 1, contents: [0: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithTwoInRow() {
        var board: Grid<Character> = Grid(dimmension: 2)
        board = markBoard(board, position: 0, team: "X")
        board = markBoard(board, position: 1, team: "X")

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeHorizontal() {
        var board: Grid<Character> = Grid(dimmension: 3)
        for i in 0...2 {
            board = markBoard(board, position: i, team: "X")
        }

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeVertical() {
        var board: Grid<Character> = Grid(dimmension: 3)
        for i in [0, 3, 6] {
            board = markBoard(board, position: i, team: "X")
        }

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeRightDiagonal() {
        var board: Grid<Character> = Grid(dimmension: 3)
        for i in [0, 4, 8] {
            board = markBoard(board, position: i, team: "X")
        }

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeLeftDiagonal() {
        var board: Grid<Character> = Grid(dimmension: 3)
        for i in [2, 4, 6] {
            board = markBoard(board, position: i, team: "X")
        }

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsNotOverWithDifferentMarksInRow() {
        var board: Grid<Character> = Grid(dimmension: 3)
        let marks: [Int: Character] = [0: "X", 1: "O", 2: "X"]
        for (position, team) in marks {
            board = markBoard(board, position: position, team: team)
        }

        XCTAssertFalse(gameIsOver(board))
    }

    func testGameIsNotOverWhenNotInRow() {
        var board: Grid<Character> = Grid(dimmension: 3)
        let marks: [Int: Character] = [0: "X", 2: "X", 4: "X"]
        for (position, team) in marks {
            board = markBoard(board, position: position, team: team)
        }

        XCTAssertFalse(gameIsOver(board))
    }

}
