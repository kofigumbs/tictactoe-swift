import XCTest
import Core

class ControllerTest: XCTestCase {

    let window = StubWindow()

    func makeController(args: [String] = [], moves: ([Int], [Int]) = ([], []))
                    -> Controller<StubPlayer, StubPlayer, StubWindow> {
        let x = StubPlayer(team: "X", moves: moves.0)
        let o = StubPlayer(team: "O", moves: moves.1)
        return Controller(window: window, players: (x, o), args: args)
    }

    func testControllerIsActiveWithEmptyBoard() {
        let controller = makeController()

        XCTAssertEqual(controller.board, Board<String>(dimmension: 3))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsToTakeFirstPlayerInput() {
        let controller = makeController(moves: ([4], []))

        controller.proceed()

        XCTAssertEqual(controller.board, Board(dimmension: 3, contents: [4: "X"]))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsToTakeFirstPlayerInputWhenReversed() {
        let controller = makeController(args: ["--second"], moves: ([], [4]))

        controller.proceed()

        XCTAssertEqual(controller.board, Board(dimmension: 3, contents: [4: "O"]))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsToAlternateMoves() {
        let controller = makeController(moves: ([0], [1]))

        controller.proceed()
        controller.proceed()

        XCTAssertEqual(controller.board, Board(dimmension: 3, contents: [0: "X", 1: "O"]))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsUntilEndOfGame() {
        let controller = makeController(moves: ([0, 1, 2], [3, 4]))

        controller.proceed()
        controller.proceed()
        controller.proceed()
        controller.proceed()
        controller.proceed()

        XCTAssertEqual(controller.board, Board(dimmension: 3, contents: [0: "X", 1: "X", 2: "X", 3: "O", 4: "O"]))
        XCTAssertFalse(controller.isActive)
    }

    func testWindowIsDrawnWhenGameIsOver() {
        let controller = makeController(moves: ([0, 1, 2], [3, 4]))

        controller.proceed()
        controller.proceed()
        controller.proceed()
        controller.proceed()
        XCTAssertEqual(window.draws, 0)

        controller.proceed()
        XCTAssertEqual(window.draws, 1)
    }

#if _runtime(_ObjC)
#else
    static var allTests: [(String, (ControllerTest) -> () throws -> Void)] {
        return [
            ("testControllerIsActiveWithEmptyBoard", testControllerIsActiveWithEmptyBoard),
            ("testControllerProceedsToTakeFirstPlayerInput", testControllerProceedsToTakeFirstPlayerInput),
            ("testControllerProceedsToTakeFirstPlayerInputWhenReversed", testControllerProceedsToTakeFirstPlayerInputWhenReversed),
            ("testControllerProceedsToAlternateMoves", testControllerProceedsToAlternateMoves),
            ("testControllerProceedsUntilEndOfGame", testControllerProceedsUntilEndOfGame),
            ("testWindowIsDrawnWhenGameIsOver", testWindowIsDrawnWhenGameIsOver)
        ]
    }
#endif

}
