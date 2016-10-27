import PackageDescription

let package = Package(
    name: "TicTacToe",
    targets : [
        Target(name: "Core"),
        Target(name: "Termbox", dependencies: [.Target(name: "Core")])
    ],
    dependencies: [
        .Package(url: "https://github.com/hkgumbs/CTermbox", Version(0, 0, 2))
    ]
)
