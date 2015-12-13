public protocol Window {

    func promptUser(prompt: String) -> String

    func drawGrid<T: Equatable>(grid: Grid<T>)

    func printMessage(message: String)

}
