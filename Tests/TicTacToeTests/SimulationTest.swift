import XCTest
import TicTacToe

class SimulationTest: XCTestCase {

    private let ui = StubUI()

    func simulate(x: [Int], o: [Int], args: [String] = []) -> (StubPlayer, StubPlayer) {
        let x = StubPlayer(team: "X", moves: x)
        let o = StubPlayer(team: "O", moves: o)
        let simulation = Simulation(ui: ui, players: (x, o), args: args)

        simulation.play()

        return (x, o)
    }

    func testSimulationWithNoMovesDoesNothing() {
        let (x, o) = simulate(x: [], o: [])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [])
        XCTAssertEqual(ui.ends, 0)
    }

    func testSimulationConsumesMoveFromPlayersInOrder() {
        let (x, o) = simulate(x: [2, 0], o: [], args: ["--fake-arg"])

        XCTAssertEqual(x.moves, [2])
        XCTAssertEqual(o.moves, [])
        XCTAssertEqual(ui.ends, 0)
    }

    func testSimulationWithFlagReversesStart() {
        let (x, o) = simulate(x: [], o: [2, 0], args: ["--second"])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [2])
        XCTAssertEqual(ui.ends, 0)
    }

    func testSimulationRunsUntilPlayerWins() {
        let (x, o) = simulate(x: [0, 1, 2], o: [3, 5, 7, 8])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [3, 5])
        XCTAssertEqual(ui.ends, 1)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SimulationTest) -> () throws -> Void)] {
        return [
            ("testSimulationWithNoMovesDoesNothing", testSimulationWithNoMovesDoesNothing),
            ("testSimulationConsumesMoveFromPlayersInOrder", testSimulationConsumesMoveFromPlayersInOrder),
            ("testSimulationWithFlagReversesStart", testSimulationWithFlagReversesStart),
            ("testSimulationRunsUntilPlayerWins", testSimulationRunsUntilPlayerWins)
        ]
    }
#endif

}
