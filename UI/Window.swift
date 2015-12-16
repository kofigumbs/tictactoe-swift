public protocol Window {

    typealias T: Hashable

    func promptUserForIndex() -> Int

    func drawGrid(grid: Grid<T>)

}
