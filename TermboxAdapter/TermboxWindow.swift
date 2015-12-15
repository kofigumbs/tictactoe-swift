import Termbox
import UI

public class TermboxWindow: Window {

    public init() { tb_init() }

    public func promptUser(prompt: String) -> String { return "" }

    public func drawGrid<T : Equatable>(grid: Grid<T>) { }

    public func printMessage(message: String) { }

    public func destroy() { tb_shutdown() }

}
