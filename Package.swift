import PackageDescription

let package = Package(
    name: "TicTacToe",
    targets : [
        Target(name: "TicTacToe"),
        Target(name: "SpriteSheet", dependencies: [
            .Target(name: "TicTacToe")
        ]),
        Target(name: "TermboxApp", dependencies: [
            .Target(name: "TicTacToe"),
            .Target(name: "SpriteSheet")
        ]),
        Target(name: "ReadlineApp", dependencies: [
            .Target(name: "TicTacToe"),
            .Target(name: "SpriteSheet")
        ]),
        Target(name: "ServerApp", dependencies: [
            .Target(name: "TicTacToe")
        ])
    ],
    dependencies: [
        .Package(url: "https://github.com/hkgumbs/Termbox", Version(0, 1, 0)),
        .Package(url: "https://github.com/vapor/vapor", Version(1, 1, 7))
    ]
)
