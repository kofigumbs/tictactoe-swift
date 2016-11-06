import SpriteSheet

struct ReadlineSprites: Sheet {

    let size = 4

    let x = [
        "x  x",
        " xx ",
        " xx ",
        "x  x"
    ]

    let o = [
        " oo ",
        "o  o",
        "o  o",
        " oo "
    ]

    let empty = [
        "    ",
        "    ",
        "    ",
        "    "
    ]

    let horizontal = [
        "    ",
        "====",
        "====",
        "    "
    ]

    let vertical = [
        " || ",
        " || ",
        " || ",
        " || "
    ]

    let junction = [
        " || ",
        "=++=",
        "=++=",
        " || "
    ]

}
