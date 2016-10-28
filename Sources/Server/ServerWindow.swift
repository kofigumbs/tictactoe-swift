import Core
import SocksCore

class ServerWindow<T: Hashable>: Window {
    let socket: TCPInternetSocket

    init?() {
        do {
            socket = try TCPInternetSocket(address: InternetAddress.any(port: 8080))
            try socket.bind()
            try socket.listen()
        } catch {
            print("This is awkward... I couldn't construct myself")
            return nil
        }
    }


    func promptUserForIndex() -> Int {
        do {
            let client = try socket.accept()
            let data = try client.recv().toString()
            try client.close()

            return try parsed(data)
        } catch {
            print("This is awkward... I blew up")
            return -1
        }
    }

    func draw(board: Board<T>) {
        do {
            let client = try socket.accept()
            let data = [UInt8](toJSON(board: board).utf8)
            try client.send(data: data)
            try client.close()
        } catch {
            print("This is awkward... I disconnected")
        }
    }

    func parsed(_ data: String) throws -> Int {
        guard let i = Int(data) else { throw NumberFormat() }
        return i
    }

    func toJSON(board: Board<T>) -> String {
        var json = "{ \n"
        board.enumerated().forEach { (i, player) in json += "\t\(i) : \(player)\n" }
        json += "}"

        return json
    }

}

struct NumberFormat: Error {}
