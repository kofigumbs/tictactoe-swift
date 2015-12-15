import XCTest
import Core

class SolverTest: XCTestCase {

    let solver = Solver(team: "X", opponent: "O")

    func assertContains<T: Equatable>(collection: [T?], target: T?) {
        let message = "Expected \(collection) to contain \(target)"
        XCTAssertTrue(collection.contains({ target == $0 }), message)
    }

    func testMakesOnlyAvailableMove() {
        let board = Board(dimmension: 3, contents:
            [ 0: "X", 1: "O", 2: "O",
              3: "X", 4: "X", 5: "O",
              6: "O", 7: "O" ])

        assertContains([8], target: solver.evaluate(board))
    }

    func testWinsWhenGivenOpportunity() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 3: "X", 4: "O"])

        assertContains([6], target: solver.evaluate(board))
    }

    func testBlocksWhenCannotWin() {
        let board = Board(dimmension: 3, contents: [0: "O", 1: "O", 3: "X"])

        assertContains([2], target: solver.evaluate(board))
    }

    func testSetsUpForFutureWin() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 2: "X", 3: "O"])

        assertContains([4, 8], target: solver.evaluate(board))
    }

    func testChoosesBestSecondMove() {
        let board = Board(dimmension: 3, contents: [0: "O"])

        assertContains([4], target: solver.evaluate(board))
    }

    func testCanSolveMultipleBoards() {
        let emptyBoard = Board<String>(dimmension: 2)
        let semiBoard = Board(dimmension: 2, contents: [0: "O", 1: "X", ])

        assertContains([0, 1, 2, 3], target: solver.evaluate(emptyBoard))
        assertContains([2, 3], target: solver.evaluate(semiBoard))
    }

    func testChoosesBestFirstMove() {
        let board = Board<String>(dimmension: 3)

        assertContains([0, 2, 6, 8], target: solver.evaluate(board))
    }

    func testSampleFourByFourPerformance() {
        self.measureBlock({
            let board = Board(dimmension: 4, contents: [0: "O"])
            self.solver.evaluate(board)
        })
    }

}

