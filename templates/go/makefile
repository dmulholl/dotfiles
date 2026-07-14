.PHONY: help
help: ## Prints available make commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[1;36m%-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: all
all: ## Builds all command binaries.
	@rm -rf ./build/** && mkdir -p ./build
	@set -e && \
		for cmd in $$(find cmd/* -maxdepth 0 -type d | xargs -I {} basename {}); do \
			printf "\e[1;32mBuilding\e[0m cmd/$$cmd\n" && \
			go build -o ./build/$$cmd ./cmd/$$cmd; \
		done

.PHONY: service
service: ## Builds the service binary.
	go build -o ./build/service ./cmd/service

.PHONY: run-service
run-service: ## Builds and runs the service binary.
	go run ./cmd/service

.PHONY: install-service
install-service: ## Builds and installs the service binary.
	go install ./cmd/service

.PHONY: script
script: ## Builds the script binary.
	go build -o ./build/script ./cmd/script

.PHONY: run-script
run-script: ## Builds and runs the script binary.
	go run ./cmd/script

.PHONY: install-script
install-script: ## Builds and installs the script binary.
	go install ./cmd/script

.PHONY: test
test: ## Runs unit tests.
	go test ./...

.PHONY: test-verbose
test-verbose: ## Runs unit tests verbosely.
	go test ./... -v

.PHONY: test-integration
test-integration: ## Runs unit and integration tests.
	go test ./... --tags integration

.PHONY: test-integration-verbose
test-integration-verbose: ## Runs unit and integration tests verbosely.
	go test ./... --tags integration -v

.PHONY: clean
clean: ## Deletes all build artifacts.
	@rm -rf ./build
	@go clean ./...
