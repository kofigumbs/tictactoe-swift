import XCTest
@testable import TicTacToeTests
@testable import SpriteSheetTests

XCTMain([
    testCase(BoardTest.allTests),
    testCase(SimulationTest.allTests),
    testCase(GameTest.allTests),
    testCase(HumanTest.allTests),
    testCase(SolverTest.allTests),
    testCase(SpriteTest.allTests)
])
