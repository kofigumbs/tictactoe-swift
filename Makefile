BUILD_TARGET = .build/debug


$(BUILD_TARGET)/libtermbox.a:
	mkdir -p $(BUILD_TARGET)
	swift package fetch
	cd Packages/CTermbox*/termbox && \
		./waf --target=termbox_static configure install
	mv Packages/CTermbox*/termbox/build/src/libtermbox.a $(BUILD_TARGET)

