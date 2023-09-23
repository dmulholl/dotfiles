build:
	@rm -rf ./build/** && mkdir -p ./build
	@set -e && \
		for cmd in $$(find cmd/* -maxdepth 0 -type d | xargs -I {} basename {}); do \
			printf "\e[1;32mBuilding\e[0m cmd/$$cmd\n" && \
			go build -o ./build/$$cmd ./cmd/$$cmd; \
		done

app:
	go build -o ./build/app ./cmd/app

run:
	go run ./cmd/app

test:
	go test ./...

test-verbose:
	go test ./... -v

test-integration:
	go test ./... --tags integration

test-integration-verbose:
	go test ./... --tags integration -v

clean:
	rm -rf ./build/*
