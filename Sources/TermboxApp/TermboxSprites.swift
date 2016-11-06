import SpriteSheet

struct TermboxSprites: Sheet {

    let size = 6

    let x = [
        "x    x",
        " x  x ",
        "  xx  ",
        "  xx  ",
        " x  x ",
        "x    x"
    ]

    let o = [
        " oooo ",
        "oooooo",
        "oo  oo",
        "oo  oo",
        "oooooo",
        " oooo "
    ]

    let empty = [
        "      ",
        "      ",
        "      ",
        "      ",
        "      ",
        "      "
    ]

    let horizontal = [
        "      ",
        "      ",
        "======",
        "======",
        "      ",
        "      "
    ]

    let vertical = [
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  ",
        "  ||  "
    ]

    let junction = [
        "  ||  ",
        "  ||  ",
        "==++==",
        "==++==",
        "  ||  ",
        "  ||  "
    ]

}
