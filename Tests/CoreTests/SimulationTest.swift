import XCTest
import Core

class SimulationTest: XCTestCase {

    var seen = [State]()

    func simulate(x: [Int], o: [Int], args: [String] = []) -> (StubPlayer, StubPlayer) {
        let x = StubPlayer(team: "X", moves: x)
        let o = StubPlayer(team: "O", moves: o)
        let simulation = Simulation(players: (x, o), args: args)
            .on(.waitingForP0) { self.seen.append(.waitingForP0) }
            .on(.waitingForP1) { self.seen.append(.waitingForP1) }
            .on(.p0Played) { self.seen.append(.p0Played) }
            .on(.p1Played) { self.seen.append(.p1Played) }
            .on(.finished) { self.seen.append(.finished) }

        simulation.start()

        return (x, o)
    }

    func testSimulationWithNoMovesDoesNothing() {
        let _ = simulate(x: [], o: [], args: ["--fake-arg"])

        XCTAssertEqual(seen, [.waitingForP0])
    }

    func testSimulationConsumesMoveFromPlayer0() {
        let (x, _) = simulate(x: [0], o: [])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(seen, [.waitingForP0, .p0Played, .waitingForP1])
    }

    func testSimulationWithFlagReversesStart() {
        let (_, o) = simulate(x: [], o: [0], args: ["--second"])

        XCTAssertEqual(o.moves, [])
        XCTAssertEqual(seen, [.waitingForP1, .p1Played, .waitingForP0])
    }

    func testSimulationRunsUntilCompletionConsumingAllMoves() {
        let (x, o) = simulate(x: [0, 1, 2], o: [3, 5])

        XCTAssertEqual(x.moves, [])
        XCTAssertEqual(o.moves, [])
        XCTAssertEqual(seen,
            [   .waitingForP0, .p0Played,
                .waitingForP1, .p1Played,
                .waitingForP0, .p0Played,
                .waitingForP1, .p1Played,
                .waitingForP0, .p0Played, .finished   ])
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (SimulationTest) -> () throws -> Void)] {
        return [
            ("testSimulationWithNoMovesDoesNothing", testSimulationWithNoMovesDoesNothing),
            ("testSimulationConsumesMoveFromPlayer0", testSimulationConsumesMoveFromPlayer0),
            ("testSimulationWithFlagReversesStart", testSimulationWithFlagReversesStart),
            ("testSimulationRunsUntilCompletionConsumingAllMoves", testSimulationRunsUntilCompletionConsumingAllMoves)
        ]
    }
#endif

}
