import XCTest
@testable import Core

class GameTest: XCTestCase {
    let emptyDict = Dictionary<Int, String>()

    func testNewGameIsNotOver() {
        let board = Board(dimmension: 3, contents: emptyDict)

        XCTAssertFalse(Game(board: board).isOver())
    }

    func testFullGameIsOver() {
        let board = Board(dimmension: 1, contents: [0: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsOverWithTwoInRow() {
        let board = Board(dimmension: 2, contents: [0: "X", 1: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsOverWithThreeHorizontal() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "X", 2: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsOverWithThreeVertical() {
        let board = Board(dimmension: 3, contents: [0: "X", 3: "X", 6: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsOverWithThreeRightDiagonal() {
        let board = Board(dimmension: 3, contents: [0: "X", 4: "X", 8: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsOverWithThreeLeftDiagonal() {
        let board = Board(dimmension: 3, contents: [2: "X", 4: "X", 6: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testGameIsNotOverWithDifferentMarksInRow() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 2: "X"])

        XCTAssertFalse(Game(board: board).isOver())
    }

    func testGameIsNotOverWhenNotInRow() {
        let board = Board(dimmension: 3, contents: [0: "X", 2: "O", 4: "X"])

        XCTAssertFalse(Game(board: board).isOver())
    }

    func testGameIsOverWhenThreeInRowPlusMore() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "X", 2: "X", 3: "X"])

        XCTAssertTrue(Game(board: board).isOver())
    }

    func testWinnerOfThreeInRow() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "X", 2: "X"])

        XCTAssertEqual(Game(board: board).winner(), "X")
    }

    func testWinnerOfThreeInColumn() {
        let board = Board(dimmension: 3, contents: [2: "O", 5: "O", 8: "O"])

        XCTAssertEqual(Game(board: board).winner(), "O")
    }

    func testWinnerOfTwoDiagonal() {
        let board = Board(dimmension: 2, contents: [0: "%", 3: "%"])

        XCTAssertEqual(Game(board: board).winner(), "%")
    }

    func testWinnerOfThreeInRowPlusMore() {
        let board = Board(dimmension: 3, contents:
            [                 2: "O",
              3: "X", 4: "X", 5: "X",
              7: "O", 8: "X"         ])

        XCTAssertEqual(Game(board: board).winner(), "X")
    }

    func testCatsGameHasNoWinner() {
        let board = Board(dimmension: 3, contents:
            [ 0: "X", 1: "O", 2: "X",
              3: "X", 4: "O", 5: "X",
              6: "O", 7: "X", 8: "O" ])

        XCTAssertNil(Game(board: board).winner())
    }

    func testEmptyGameHasNoWinner() {
        let board = Board(dimmension: 3, contents: emptyDict)

        XCTAssertNil(Game(board: board).winner())
    }

}

