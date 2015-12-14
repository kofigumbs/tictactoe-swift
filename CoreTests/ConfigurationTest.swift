import XCTest
import Core

class ConfigurationTest: XCTestCase {

    let playerOne = StubPlayer(team: "X")
    let playerTwo = StubPlayer(team: "O")

    func testConfigurationSetsDefaultsWithNoArgs() {
        let config = Configuration(players: (playerOne, playerTwo), args: [])

        XCTAssertEqual(config.players.first.team, playerOne.team)
        XCTAssertEqual(config.players.second.team, playerTwo.team)
        XCTAssertEqual(config.board, Board<String>(dimmension: 3))
    }

    func testConfigurationReversesPlayers() {
        let config = Configuration(players: (playerOne, playerTwo), args: ["--reverse"])

        XCTAssertEqual(config.players.first.team, playerTwo.team)
        XCTAssertEqual(config.players.second.team, playerOne.team)
    }

    func testConfigurationSetsBoardDimmension() {
        let config = Configuration(players: (playerOne, playerTwo), args: ["--four"])

        XCTAssertEqual(config.board, Board<String>(dimmension: 4))
    }

    func testConfigurationCombinesOptions() {
        let config = Configuration(players: (playerOne, playerTwo), args: ["--reverse", "--four"])

        XCTAssertEqual(config.players.first.team, playerTwo.team)
        XCTAssertEqual(config.players.second.team, playerOne.team)
        XCTAssertEqual(config.board, Board<String>(dimmension: 4))
    }

}

