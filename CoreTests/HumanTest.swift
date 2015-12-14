import XCTest
import UI
@testable import Core

class HumanTest: XCTestCase {

    func testHumanCanMove() {
        let window = StubWindow(responses: ["2", "4"])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3)

        XCTAssertEqual(human.evaluate(board), 4)
        XCTAssertEqual(human.evaluate(board), 2)
    }

    func testHumanRetriesOnInvalidMove() {
        let window = StubWindow(responses: ["4", "hello", "world"])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3)

        XCTAssertEqual(human.evaluate(board), 4)
    }

    func testHumanRetriesOnOccupiedSpace() {
        let window = StubWindow(responses: ["3", "5", "4"])
        let human = Human(team: "X", window: window)
        let board = Board<String>(dimmension: 3, contents: [4: "X", 5: "O"])

        XCTAssertEqual(human.evaluate(board), 3)
    }

}

