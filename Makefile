BUILD_TARGET = $(CURDIR)/.build
BUILD_MODE=debug


$(BUILD_TARGET)/libtermbox.a:
	swift package fetch
	cd Packages/CTermbox*/termbox && \
		./waf --target=termbox_static --prefix=$(BUILD_TARGET) --libdir=$(BUILD_TARGET)/$(BUILD_MODE) configure install

