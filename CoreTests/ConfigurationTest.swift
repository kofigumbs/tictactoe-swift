import XCTest
import Core

class ConfigurationTest: XCTestCase {

    let playerOne = StubPlayer(team: "X")
    let playerTwo = StubPlayer(team: "O")

    func testConfigurationSetsPlayers() {
        let config = Configuration(players: (playerOne, playerTwo), args: ["program-name"])

        XCTAssertEqual(config.players.first.team, playerOne.team)
        XCTAssertEqual(config.players.second.team, playerTwo.team)
    }

    func testConfigurationReversesPlayers() {
        let config = Configuration(players: (playerOne, playerTwo), args: ["program-name", "--reverse"])

        XCTAssertEqual(config.players.first.team, playerTwo.team)
        XCTAssertEqual(config.players.second.team, playerOne.team)
    }

}

