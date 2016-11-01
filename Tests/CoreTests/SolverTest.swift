import XCTest
import Core

class SolverTest: XCTestCase {

    let solver = Solver(team: "X", opponent: "O")
    var move: Int?

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

        solver.evaluate(board: board) { move = $0 }

        assertThat(collection: [8], contains: move)
    }

    func testWinsWhenGivenOpportunity() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 3: "X", 4: "O"])

        solver.evaluate(board: board) { move = $0 }

        assertThat(collection: [6], contains: move)
    }

    func testBlocksWhenCannotWin() {
        let board = Board(dimmension: 3, contents: [0: "O", 1: "O", 3: "X"])

        solver.evaluate(board: board) { move = $0 }

        assertThat(collection: [2], contains: move)
    }

    func testSetsUpForFutureWin() {
        let board = Board(dimmension: 3, contents: [0: "X", 1: "O", 2: "X", 3: "O"])

        solver.evaluate(board: board) { move = $0 }

        assertThat(collection: [4, 8], contains: move)
    }

    func testCanSolveMultipleBoards() {
        let board1 = Board(dimmension: 3, contents: [0: "O"])
        solver.evaluate(board: board1) { move = $0 }
        assertThat(collection: [4], contains: move)

        let board2 = Board(dimmension: 3, contents: [0: "O", 1: "X", 4: "O"])
        solver.evaluate(board: board2) { move = $0 }
        assertThat(collection: [8], contains: move)
    }

    func testChoosesBestFirstMove() {
        let board = Board<String>(dimmension: 3)

        solver.evaluate(board: board) { move = $0 }

        assertThat(collection: [0, 2, 6, 8], contains: move)
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
