help: ## Prints available commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[1;36m%-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: ## Builds all command binaries.
	@rm -rf ./build/** && mkdir -p ./build
	@set -e && \
		for cmd in $$(find cmd/* -maxdepth 0 -type d | xargs -I {} basename {}); do \
			printf "\e[1;32mBuilding\e[0m cmd/$$cmd\n" && \
			go build -o ./build/$$cmd ./cmd/$$cmd; \
		done

app: ## Builds the cmd/app binary.
	go build -o ./build/app ./cmd/app

run: ## Builds and runs the cmd/app binary.
	go run ./cmd/app

test: ## Runs unit tests.
	go test ./...

test-verbose: ## Runs unit tests verbosely.
	go test ./... -v

test-integration: ## Runs unit and integration tests.
	go test ./... --tags integration

test-integration-verbose: ## Runs unit and integration tests verbosely.
	go test ./... --tags integration -v

clean: ## Deletes all build artifacts.
	rm -rf ./build/*
