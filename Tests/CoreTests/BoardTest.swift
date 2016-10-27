import XCTest
@testable import Core

class BoardTest: XCTestCase {

    func testCanMarkBoard() {
        let board = Board<String>(dimmension: 3)
        let newBoard = board.marked(at: 0, with: "X")

        XCTAssertEqual(newBoard[0], "X")
    }

    func testCanMarkMarkedBoard() {
        let board = Board<String>(dimmension: 3, contents: [1: "O"])
        let newBoard = board.marked(at: 0, with: "X")

        XCTAssertEqual(newBoard[0], "X")
        XCTAssertEqual(newBoard[1], "O")
    }

    func testBoardIsNotFull() {
        let board = Board<String>(dimmension: 2)

        XCTAssertTrue(board.isEmpty)
        XCTAssertFalse(board.isFull)
    }

    func testBoardIsFull() {
        let board = Board<String>(dimmension: 2, contents: [0: "A", 1: "B", 2: "C", 3: "D"])

        XCTAssertFalse(board.isEmpty)
        XCTAssertTrue(board.isFull)
    }

    func testAvailablePositionsWhenEmpty() {
        let board = Board<String>(dimmension: 2)

        XCTAssertEqual(board.availableSpaces(), [0, 1, 2, 3])
    }

    func testAvailablePositionsWhenNotEmpty() {
        let board = Board<String>(dimmension: 2, contents: [1: "$", 2: "#"])

        XCTAssertEqual(board.availableSpaces(), [0, 3])
    }

    func testEquatable() {
        let board1 = Board<String>(dimmension: 3)
        let board2 = Board<String>(dimmension: 3)
        let board3 = Board(dimmension: 3, contents: [0: "X"])

        XCTAssertEqual(board1, board1)
        XCTAssertEqual(board2, board2)
        XCTAssertEqual(board1, board2)
        XCTAssertNotEqual(board1, board3)
        XCTAssertNotEqual(board2, board3)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (BoardTest) -> () throws -> Void)] {
        return [
            ("testCanMarkBoard", testCanMarkBoard),
            ("testCanMarkMarkedBoard", testCanMarkMarkedBoard),
            ("testBoardIsNotFull", testBoardIsNotFull),
            ("testBoardIsFull", testBoardIsFull),
            ("testAvailablePositionsWhenEmpty", testAvailablePositionsWhenEmpty),
            ("testAvailablePositionsWhenNotEmpty", testAvailablePositionsWhenNotEmpty),
            ("testEquatable", testEquatable)
        ]
    }
#endif

}
