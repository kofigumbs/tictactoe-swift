import XCTest
@testable import TicTacToe

class HumanTest: XCTestCase {

    func testHumanCanMove() {
        let ui = StubUI(responses: [2, 4])
        let human = Human(team: "X", ui: ui)
        let board = Board<String>(dimmension: 3)
        var move: Int?

        human.evaluate(board: board) { move = $0 }
        XCTAssertEqual(move, 4)

        human.evaluate(board: board) { move = $0 }
        XCTAssertEqual(move, 2)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (HumanTest) -> () throws -> Void)] {
        return [
            ("testHumanCanMove", testHumanCanMove)
        ]
    }
#endif

}
