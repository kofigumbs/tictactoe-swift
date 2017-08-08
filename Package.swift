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
        .Package(url: "https://github.com/dduan/Termbox.git", "1.0.0-dev.1"),
        .Package(url: "https://github.com/vapor/vapor", Version(2, 1, 2))
    ]
)
