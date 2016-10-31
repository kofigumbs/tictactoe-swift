import XCTest
@testable import Core

class HumanTest: XCTestCase {

    func testHumanCanMove() {
        let ui = StubUI(responses: [2, 4])
        let human = Human(team: "X", ui: ui)
        let board = Board<String>(dimmension: 3)

        XCTAssertEqual(human.evaluate(board: board), 4)
        XCTAssertEqual(human.evaluate(board: board), 2)
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
