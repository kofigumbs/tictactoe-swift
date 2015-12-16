public protocol Window {

    typealias T: Hashable

    func promptUser(prompt: String) -> String

    func drawGrid(grid: Grid<T>)

    func printMessage(message: String)

}
