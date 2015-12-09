public protocol UserInterface {

    typealias Cell: Equatable

    func getUserInput(prompt: String) -> String

    func draw(grid: Grid<Cell>)

    func print(message: String)

}
