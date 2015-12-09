import XCTest
import UI

class GridTest: XCTestCase {

    func testCreatesEmptyGrid() {
        let grid: Grid<String> = Grid(dimmension: 3)

        XCTAssertTrue(grid.isEmpty)
    }

    func testCreatesGridWithOneCell() {
        let grid: Grid<String> = Grid(dimmension: 3, contents: (0, "Cell 0"))

        XCTAssertFalse(grid.isEmpty)
        XCTAssertEqual(grid[0], "Cell 0")
    }

    func testCreatesGridWithTwoCells() {
        let grid: Grid<String> = Grid(dimmension: 3, contents: (0, "Cell 0"), (8, "Cell 8"))

        XCTAssertFalse(grid.isEmpty)
        XCTAssertEqual(grid[0], "Cell 0")
        XCTAssertEqual(grid[8], "Cell 8")
    }

    func testNonInitializedValuesAreNil() {
        let grid: Grid<String> = Grid(dimmension: 3, contents: (1, "Cell 1"))

        XCTAssertEqual(grid[0], nil)
        XCTAssertEqual(grid[1], "Cell 1")
    }

    func testCannotSetValuesOutOfBounds() {
        let grid: Grid<String> = Grid(dimmension: 3, contents: (-1, "Cell -1"), (15, "Cell 15"))

        XCTAssertTrue(grid.isEmpty)
        XCTAssertNil(grid[-1])
        XCTAssertNil(grid[15])
    }

}
