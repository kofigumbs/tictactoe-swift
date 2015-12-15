test: _testCore _testUI

_testCore:
	xcodebuild test -scheme Core

_testUI:
	xcodebuild test -scheme UI

clean:
	xcodebuild clean
	rm -rf TermboxAdapter/Termbox/build

build: _buildTermbox
	xcodebuild build

_buildTermbox:
	git submodule init
	cd TermboxAdapter/Termbox; ./waf configure; ./waf

