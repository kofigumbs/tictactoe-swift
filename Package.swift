import PackageDescription

let package = Package(
    name: "TicTacToe",
    targets : [
        Target(name: "Core"),
        Target(name: "TermboxApp", dependencies: [.Target(name: "Core")]),
        Target(name: "ReadlineApp", dependencies: [.Target(name: "Core")]),
        Target(name: "ServerApp", dependencies: [.Target(name: "Core")])
    ],
    dependencies: [
        .Package(url: "https://github.com/hkgumbs/Termbox", Version(0, 0, 4)),
        .Package(url: "https://github.com/vapor/socks", Version(1, 0, 1))
    ]
)
