> Third time's a charm. -- *Unknown*


# Please...
 - install Xcode 7.1+
 - run `xcodebuild` and accept Apple user agreement if prompted
 - don't mind when I install to your `/usr/local`


# How do I ...
?                      | command
-----------------------|--------
run tests              | `make test`
build the executable   | `make build`
run the executable     | `./build/Release/TicTacToe`
play second            | `./build/Release/TicTacToe --second`
clean up               | `make clean`
control stuff          | arrow keys + enter


# Note ...
 - the console warnings after the running the executable seem to be the price for using multiple Swift frameworks in a binary executable
 - [Termbox](https://github.com/nsf/termbox) is a library written by a fellow called nsf
