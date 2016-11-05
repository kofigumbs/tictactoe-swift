import XCTest
@testable import TicTacToe

class HumanTest: XCTestCase {
    var move: Int?

    func testHumanMovesWithUiMove() {
        let ui = StubUI(responses: [2])
        let human = Human(team: "X", ui: ui)
        let board = Board<String>(dimmension: 3)

        human.evaluate(board: board) { self.move = $0 }

        XCTAssertEqual(move, 2)
    }

    func testHumanWaitsUntilValidMove() {
        let ui = StubUI(responses: [1, 0, 2, 2, 3, 4])
        let human = Human(team: "X", ui: ui)
        let board = Board<String>(dimmension: 3)
            .marked(at: 4, with: "O")
            .marked(at: 3, with: "X")
            .marked(at: 2, with: "O")

        human.evaluate(board: board) { self.move = $0 }

        XCTAssertEqual(move, 0)
        XCTAssertEqual(ui.responses, [1])
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (HumanTest) -> () throws -> Void)] {
        return [
            ("testHumanMovesWithUiMove", testHumanMovesWithUiMove),
            ("testHumanWaitsUntilValidMove", testHumanWaitsUntilValidMove)
        ]
    }
#endif

}
