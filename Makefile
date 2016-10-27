TERMBOX_DIR = $(wildcard Packages/CTermbox*/termbox)
SWIFT_LINK_FLAGS = -Xlinker -L$(TERMBOX_DIR)/build/src



install:
	swift package fetch
	cd $(TERMBOX_DIR) && \
		./waf --target=termbox_static configure install


build:
	swift build $(SWIFT_LINK_FLAGS)


clean:
	swift build --clean
	cd $(TERMBOX_DIR) && \
	   	./waf clean


test:
	swift test --color always $(SWIFT_LINK_FLAGS)
