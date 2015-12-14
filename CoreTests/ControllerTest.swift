import XCTest
import Core

class ControllerTest: XCTestCase {

    let window = StubWindow()

    func makeController(args: [String] = [], moves: ([Int], [Int]) = ([], [])) -> Controller<StubPlayer> {
        let players = (StubPlayer(team: "X", moves: moves.0), StubPlayer(team: "O", moves: moves.1))
        let configuration = Configuration(players: players, args: args)
        return Controller(window: window, configuration: configuration)
    }

    func testControllerIsActiveWithEmptyBoard() {
        let controller = makeController()

        XCTAssertEqual(controller.board, Board(dimmension: 3))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerUsesConfigurationBoard() {
        let controller = makeController(["--four"])

        XCTAssertEqual(controller.board, Board(dimmension: 4))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsToTakeFirstPlayerInput() {
        let controller = makeController(moves: ([4], []))

        controller.proceed()

        XCTAssertEqual(controller.board, Board(dimmension: 3, contents: [4: "X"]))
        XCTAssertTrue(controller.isActive)
    }

    func testControllerProceedsToTakeFirstPlayerInputWhenReversed() {
        let controller = makeController(["--reverse"], moves: ([], [4]))

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

    func testWindowIsDrawnEachTime() {
        let controller = makeController(moves: ([0], [1]))

        controller.proceed()
        XCTAssertEqual(window.draws, 1)

        controller.proceed()
        XCTAssertEqual(window.draws, 2)
    }

}
