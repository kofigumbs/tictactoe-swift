import XCTest
import UI
@testable import Core

class GameTest: XCTestCase {

    func fillBoard<T: Equatable>(dimmension: Int, marks: [Int: T]) -> Grid<T> {
        return marks.reduce(Grid<T>(dimmension: dimmension), combine: { (grid, mark) in
            markBoard(grid, position: mark.0, team: mark.1)
        })
    }

    func testNewGameIsNotOver() {
        let board: Grid<Character> = Grid(dimmension: 3)

        XCTAssertFalse(gameIsOver(board))
    }

    func testFullGameIsOver() {
        let board = fillBoard(1, marks: [0: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithTwoInRow() {
        let board = fillBoard(2, marks: [0: "X", 1: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeHorizontal() {
        let board = fillBoard(3, marks: [0: "X", 1: "X", 2: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeVertical() {
        let board = fillBoard(3, marks: [0: "X", 3: "X", 6: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeRightDiagonal() {
        let board = fillBoard(3, marks: [0: "X", 4: "X", 8: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsOverWithThreeLeftDiagonal() {
        let board = fillBoard(3, marks: [2: "X", 4: "X", 6: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testGameIsNotOverWithDifferentMarksInRow() {
        let board = fillBoard(3, marks: [0: "X", 1: "O", 2: "X"])

        XCTAssertFalse(gameIsOver(board))
    }

    func testGameIsNotOverWhenNotInRow() {
        let board = fillBoard(3, marks: [0: "X", 2: "O", 4: "X"])

        XCTAssertFalse(gameIsOver(board))
    }

    func testGameIsOverWhenThreeInRowPlusMore() {
        let board = fillBoard(3, marks: [0: "X", 1: "X", 2: "X", 3: "X"])

        XCTAssertTrue(gameIsOver(board))
    }

    func testWinnerOfThreeInRow() {
        let board = fillBoard(3, marks: [0: "X", 1: "X", 2: "X"])

        XCTAssertEqual(winnerOf(board), "X")
    }

    func testWinnerOfThreeInColumn() {
        let board = fillBoard(3, marks: [2: "O", 5: "O", 8: "O"])

        XCTAssertEqual(winnerOf(board), "O")
    }

    func testWinnerOfTwoDiagonal() {
        let board = fillBoard(2, marks: [0: "%", 3: "%"])

        XCTAssertEqual(winnerOf(board), "%")
    }

    func testCatsGameHasNoWinner() {
        let moves = Dictionary<Int, String>(dictionaryLiteral:
            (0, "X"), (1, "O"), (2, "X"),
            (3, "X"), (4, "O"), (5, "X"),
            (6, "O"), (7, "X"), (8, "O"))
        let board = fillBoard(3, marks: moves)

        XCTAssertNil(winnerOf(board))
    }

    func testEmptyGameHasNoWinner() {
        let board = Grid<String>(dimmension: 3)

        XCTAssertNil(winnerOf(board))
    }

}
