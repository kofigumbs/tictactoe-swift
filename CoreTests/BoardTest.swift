import XCTest
@testable import Core

class BoardTest: XCTestCase {
    let emptyDict = Dictionary<Int, String>()

    func testCanMarkBoard() {
        let board = Board<String>(dimmension: 3, contents: emptyDict)
        let newBoard = board.markAt(0, with: "X")

        XCTAssertEqual(newBoard[0], "X")
    }

    func testCanMarkMarkedBoard() {
        let board = Board<String>(dimmension: 3, contents: [1: "O"])
        let newBoard = board.markAt(0, with: "X")

        XCTAssertEqual(newBoard[0], "X")
        XCTAssertEqual(newBoard[1], "O")
    }

    func testBoardIsNotFull() {
        let board = Board<String>(dimmension: 2, contents: emptyDict)

        XCTAssertTrue(board.isEmpty)
        XCTAssertFalse(board.isFull)
    }

    func testBoardIsFull() {
        let board = Board<String>(dimmension: 2, contents: [0: "A", 1: "B", 2: "C", 3: "D"])

        XCTAssertFalse(board.isEmpty)
        XCTAssertTrue(board.isFull)
    }

    func testAvailablePositionsWhenEmpty() {
        let board = Board<String>(dimmension: 2, contents: emptyDict)

        XCTAssertEqual(board.availableSpaces(), [0, 1, 2, 3])
    }

    func testAvailablePositionsWhenNotEmpty() {
        let board = Board<String>(dimmension: 2, contents: [1: "$", 2: "#"])

        XCTAssertEqual(board.availableSpaces(), [0, 3])
    }

}