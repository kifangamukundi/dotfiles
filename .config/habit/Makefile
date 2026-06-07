.PHONY: build install uninstall test run clean

build:
	go build -o habit cmd/habit/main.go

install:
	./scripts/install.sh

uninstall:
	./scripts/uninstall.sh

test:
	go test ./...

run: build
	./habit --config configs/config.yaml

clean:
	rm -f habit cache.json
