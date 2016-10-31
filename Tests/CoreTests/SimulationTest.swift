import XCTest
import Core

class SimulationTest: XCTestCase {

    func makeSimulation(args: [String] = [], moves: ([Int], [Int]) = ([], []))
                    -> Simulation<StubPlayer, StubPlayer> {
        let x = StubPlayer(team: "X", moves: moves.0)
        let o = StubPlayer(team: "O", moves: moves.1)
        return Simulation(players: (x, o), args: args)
    }

    func testSimulationIsActiveWithEmptyBoard() {
        let simulation = makeSimulation()

        XCTAssertEqual(simulation.board, Board<String>(dimmension: 3))
        XCTAssertTrue(simulation.isActive)
    }

    func testSimulationProceedsToTakeFirstPlayerInput() {
        let simulation = makeSimulation(moves: ([4], []))

        simulation.proceed()

        XCTAssertEqual(simulation.board, Board(dimmension: 3, contents: [4: "X"]))
        XCTAssertTrue(simulation.isActive)
    }

    func testSimulationProceedsToTakeFirstPlayerInputWhenReversed() {
        let simulation = makeSimulation(args: ["--second"], moves: ([], [4]))

        simulation.proceed()

        XCTAssertEqual(simulation.board, Board(dimmension: 3, contents: [4: "O"]))
        XCTAssertTrue(simulation.isActive)
    }

    func testSimulationProceedsToAlternateMoves() {
        let simulation = makeSimulation(moves: ([0], [1]))

        simulation.proceed()
        simulation.proceed()

        XCTAssertEqual(simulation.board, Board(dimmension: 3, contents: [0: "X", 1: "O"]))
        XCTAssertTrue(simulation.isActive)
    }

    func testSimulationProceedsUntilEndOfGame() {
        let simulation = makeSimulation(moves: ([0, 1, 2], [3, 4]))

        simulation.proceed()
        simulation.proceed()
        simulation.proceed()
        simulation.proceed()
        simulation.proceed()

        XCTAssertEqual(simulation.board, Board(dimmension: 3, contents: [0: "X", 1: "X", 2: "X", 3: "O", 4: "O"]))
        XCTAssertFalse(simulation.isActive)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SimulationTest) -> () throws -> Void)] {
        return [
            ("testSimulationIsActiveWithEmptyBoard", testSimulationIsActiveWithEmptyBoard),
            ("testSimulationProceedsToTakeFirstPlayerInput", testSimulationProceedsToTakeFirstPlayerInput),
            ("testSimulationProceedsToTakeFirstPlayerInputWhenReversed", testSimulationProceedsToTakeFirstPlayerInputWhenReversed),
            ("testSimulationProceedsToAlternateMoves", testSimulationProceedsToAlternateMoves),
            ("testSimulationProceedsUntilEndOfGame", testSimulationProceedsUntilEndOfGame),
        ]
    }
#endif

}
