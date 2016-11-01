import XCTest
@testable import TicTacToeTests

XCTMain([
    testCase(BoardTest.allTests),
    testCase(SimulationTest.allTests),
    testCase(GameTest.allTests),
    testCase(HumanTest.allTests),
    testCase(SolverTest.allTests)
])
