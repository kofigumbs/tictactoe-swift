import XCTest

struct OneByOne {
    let size = 1
    let x = [ "x" ]
    let o = [ "o" ]
    let empty = [ " " ]
    let vertical = [ "|" ]
    let horizontal = [ "-" ]
    let junction = [ "+" ]
}

struct LargerSprites {
    let size = 2

    let x = [
        "TR",
        "UE"
    ]

    let o = [
        "FA",
        "LS"
    ]

    let empty = [
        "EM",
        "PT"
    ]

    let vertical = [
        "VE",
        "RT"
    ]

    let horizontal = [
        "HO",
        "RI"
    ]

    let junction = [
        "JU",
        "NC"
    ]
}

func === (lhs: [[UnicodeScalar]], rhs: [[UnicodeScalar]]) {
    for (i, row) in lhs.enumerated() {
        for (j, cell) in row.enumerated() {
            XCTAssertEqual(cell, rhs[i][j])
        }
    }
}
