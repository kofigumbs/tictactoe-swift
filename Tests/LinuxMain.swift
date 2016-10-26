import XCTest
@testable import CoreTests

XCTMain([
    testCase(BoardTest.allTests),
    testCase(ControllerTest.allTests),
    testCase(GameTest.allTests),
    testCase(HumanTest.allTests),
    testCase(SolverTest.allTests)
])
