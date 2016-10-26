TERMBOX_PACKAGE := $(wildcard Packages/CTermbox*/termbox)
SWIFT_FLAGS = -Xlinker -L$(TERMBOX_PACKAGE)/build/src

.INTSTALL:
	swift package fetch
	cd $(TERMBOX_PACKAGE); ./waf configure; ./waf

build: .INTSTALL
	swift build $(SWIFT_FLAGS)

test: .INTSTALL
	swift test $(SWIFT_FLAGS)
