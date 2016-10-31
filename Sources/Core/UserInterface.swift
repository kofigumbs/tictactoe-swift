public protocol UserInterface {

    associatedtype Mark: Hashable

    func promptMove(on board: Board<Mark>) -> Int

}
