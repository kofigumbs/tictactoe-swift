import XCTest
@testable import CoreTests

XCTMain([
    testCase(BoardTest.allTests),
    testCase(SimulationTest.allTests),
    testCase(GameTest.allTests),
    testCase(HumanTest.allTests),
    testCase(SolverTest.allTests)
])
