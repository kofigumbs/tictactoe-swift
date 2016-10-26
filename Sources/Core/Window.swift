public protocol Window {

    associatedtype T: Hashable

    func promptUserForIndex() -> Int

    func draw(grid: Grid<T>)

}
