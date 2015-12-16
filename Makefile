test: _testCore _testUI

_testCore:
	xcodebuild test -scheme CoreTests

_testUI:
	xcodebuild test -scheme UITests

clean:
	xcodebuild clean
	cd TermboxAdapter/Termbox; ./waf uninstall
	rm -rf TermboxAdapter/Termbox/build

build: _buildTermbox
	xcodebuild build

_buildTermbox:
	git submodule init
	cd TermboxAdapter/Termbox; ./waf configure; ./waf; ./waf install

