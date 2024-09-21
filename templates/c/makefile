# ----------- #
#  Variables  #
# ----------- #

CFLAGS = -Wall -Wextra --std=c11 --pedantic -Wno-unused-parameter -Wno-unused-function

RELEASE_FLAGS = -O2 -D NDEBUG
DEBUG_FLAGS = -D DEBUG

# --------------- #
#  Phony Targets  #
# --------------- #

.PHONY: help
help: ## Prints available commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[1;36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: all
all: ## Builds both the release and debug binaries.
	@make debug
	@make release

.PHONY: release
release: ## Builds the release binary.
	@mkdir -p build/release
	@printf "\e[1;32mBuilding\e[0m build/release/app (release)\n"
	@$(CC) $(CFLAGS) $(RELEASE_FLAGS) -o build/release/app src/*.c

.PHONY: debug
debug: ## Builds the debug binary.
	@mkdir -p build/debug
	@printf "\e[1;32mBuilding\e[0m build/debug/app (debug)\n"
	@$(CC) $(CFLAGS) $(DEBUG_FLAGS) -o build/debug/app src/*.c

.PHONY: run
run: ## Builds and runs the debug binary.
	@make debug
	./build/debug/app

.PHONY: clean
clean: ## Deletes all build artifacts.
	rm -rf ./build
