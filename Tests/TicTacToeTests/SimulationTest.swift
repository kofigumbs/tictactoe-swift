import XCTest
import TicTacToe

class SimulationTest: XCTestCase {

    func simulate(x: [Int], o: [Int], args: [String] = []) -> (StubPlayer, StubPlayer) {
        let x = StubPlayer(team: "X", moves: x)
        let o = StubPlayer(team: "O", moves: o)
        let simulation = Simulation(players: (x, o), args: args)

        simulation.start()

        return (x, o)
    }

    func testSimulationWithNoMovesDoesNothing() {
        let (x, o) = simulate(x: [], o: [], args: ["--fake-arg"])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [])
    }

    func testSimulationConsumesMoveFromPlayer0() {
        let (x, o) = simulate(x: [0], o: [])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [])
    }

    func testSimulationWithFlagReversesStart() {
        let (x, o) = simulate(x: [], o: [0], args: ["--second"])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [])
    }

    func testSimulationRunsUntilPlayerWins() {
        let (x, o) = simulate(x: [0, 1, 2], o: [3, 5, 7, 8])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [3, 5])
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SimulationTest) -> () throws -> Void)] {
        return [
            ("testSimulationWithNoMovesDoesNothing", testSimulationWithNoMovesDoesNothing),
            ("testSimulationConsumesMoveFromPlayer0", testSimulationConsumesMoveFromPlayer0),
            ("testSimulationWithFlagReversesStart", testSimulationWithFlagReversesStart),
            ("testSimulationRunsUntilPlayerWins", testSimulationRunsUntilPlayerWins)
        ]
    }
#endif

}
