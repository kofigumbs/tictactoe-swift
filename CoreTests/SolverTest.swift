import XCTest
@testable import Core

class SolverTest: XCTestCase {

    let solver = Solver(team: "X", opponent: "O")

    func assertContains<T: Equatable>(collection: [T], target: T?) {
        let message = "Expected \(collection) to contain \(target)"
        XCTAssertTrue(collection.contains({ target == $0 }), message)
    }

    func testReturnsNilIfBoardIsFull() {
        let board = Board(dimmension: 3, contents:
            [ 0: "X", 1: "O", 2: "X",
              3: "O", 4: "X", 5: "O",
              6: "O", 7: "O", 8: "X" ])

        XCTAssertNil(solver.solve(board))
    }

    func testMakesOnlyAvailableMove() {
        let board = Board(dimmension: 3, contents:
            [ 0: "X", 1: "O", 2: "O",
              3: "X", 4: "X", 5: "O",
              6: "O", 7: "O" ])

        assertContains([8], target: solver.solve(board))
    }

    func testWinsWhenGivenOpportunity() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 3: "X", 4: "O"])

        assertContains([6], target: solver.solve(board))
    }

    func testBlocksWhenCannotWin() {
        let board = Board(dimmension: 3, contents: [0: "O", 1: "O", 3: "X"])

        assertContains([2], target: solver.solve(board))
    }

    func testSetsUpForFutureWin() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 2: "X", 3: "O"])

        assertContains([4, 8], target: solver.solve(board))
    }

    func testChoosesBestSecondMove() {
        let board = Board(dimmension: 3, contents: [0: "O"])

        assertContains([4], target: solver.solve(board))
    }

}
