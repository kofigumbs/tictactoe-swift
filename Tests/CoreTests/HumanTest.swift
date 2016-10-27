import XCTest
@testable import Core

class HumanTest: XCTestCase {

    func testHumanCanMove() {
        let window = StubWindow(responses: [2, 4])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3)

        XCTAssertEqual(human.evaluate(board: board), 4)
        XCTAssertEqual(human.evaluate(board: board), 2)
    }

    func testHumanRetriesOnInvalidSpace() {
        let window = StubWindow(responses: [3, 5, -1, 4])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3, contents: [4: "X", 5: "O"])

        XCTAssertEqual(human.evaluate(board: board), 3)
    }

    func testHumanDrawsGridToWindow() {
        let window = StubWindow(responses: [3, 5, 4])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3, contents: [4: "X", 5: "O"])

        XCTAssertEqual(window.draws, 0)

        let _ = human.evaluate(board: board)

        XCTAssertEqual(window.draws, 1)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (HumanTest) -> () throws -> Void)] {
        return [
            ("testHumanCanMove", testHumanCanMove),
            ("testHumanRetriesOnInvalidSpace", testHumanRetriesOnInvalidSpace),
            ("testHumanDrawsGridToWindow", testHumanDrawsGridToWindow)
        ]
    }
#endif

}
