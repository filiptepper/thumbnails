export GOPATH=$(CURDIR)

BIN=thumbnails

default: compile

compile:
	go install $(BIN)

run:	compile
	./bin/$(BIN)

test:	compile
	go test $(BIN)

clean:
	rm -rf pkg
	rm -rf bin

