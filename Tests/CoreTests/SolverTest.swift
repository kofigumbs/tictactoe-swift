import XCTest
import Core

class SolverTest: XCTestCase {

    let solver = Solver(team: "X", opponent: "O")

    func assertThat<T: Equatable>(collection: [T], contains target: T?) {
        let message = "Expected \(collection) to contain \(target)"
        XCTAssertTrue(collection.contains { target == $0 }, message)
    }

    func testSolverTeam() {
        XCTAssertEqual(solver.team, "X")
    }

    func testMakesOnlyAvailableMove() {
        let board = Board(dimmension: 3, contents:
            [ 0: "X", 1: "O", 2: "O",
              3: "X", 4: "X", 5: "O",
              6: "O", 7: "O" ])

        assertThat(collection: [8], contains: solver.evaluate(board: board))
    }

    func testWinsWhenGivenOpportunity() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 3: "X", 4: "O"])

        assertThat(collection: [6], contains: solver.evaluate(board: board))
    }

    func testBlocksWhenCannotWin() {
        let board = Board(dimmension: 3, contents: [0: "O", 1: "O", 3: "X"])

        assertThat(collection: [2], contains: solver.evaluate(board: board))
    }

    func testSetsUpForFutureWin() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 2: "X", 3: "O"])

        assertThat(collection: [4, 8], contains: solver.evaluate(board: board))
    }

    func testCanSolveMultipleBoards() {
        let board1 = Board(dimmension: 3, contents: [0: "O"])
        let board2 = Board(dimmension: 3, contents: [0: "O", 1: "X", 4: "O"])

        assertThat(collection: [4], contains: solver.evaluate(board: board1))
        assertThat(collection: [8], contains: solver.evaluate(board: board2))
    }

    func testChoosesBestFirstMove() {
        let board = Board<String>(dimmension: 3)

        assertThat(collection: [0, 2, 6, 8], contains: solver.evaluate(board: board))
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SolverTest) -> () throws -> Void)] {
        return [
            ("testSolverTeam", testSolverTeam),
            ("testMakesOnlyAvailableMove", testMakesOnlyAvailableMove),
            ("testWinsWhenGivenOpportunity", testWinsWhenGivenOpportunity),
            ("testBlocksWhenCannotWin", testBlocksWhenCannotWin),
            ("testSetsUpForFutureWin", testSetsUpForFutureWin),
            ("testCanSolveMultipleBoards", testCanSolveMultipleBoards),
            ("testChoosesBestFirstMove", testChoosesBestFirstMove)
        ]
    }
#endif

}
