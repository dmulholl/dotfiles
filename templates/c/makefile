# ----------- #
#  Variables  #
# ----------- #

CFLAGS = -Wall -Wextra --std=c11 --pedantic -Wno-unused-parameter -Wno-unused-function

RELEASE_FLAGS = -O3 -D NDEBUG
DEBUG_FLAGS = -D DEBUG

# --------------- #
#  Phony Targets  #
# --------------- #

debug: ## Builds the debug binary.
	@mkdir -p out
	@printf "\e[1;32mBuilding\e[0m out/app (debug)\n"
	@$(CC) $(CFLAGS) $(DEBUG_FLAGS) -o out/app src/*.c

release: ## Builds the release binary.
	@mkdir -p out
	@printf "\e[1;32mBuilding\e[0m out/app (release)\n"
	@$(CC) $(CFLAGS) $(RELEASE_FLAGS) -o out/app src/*.c

run: ## Builds and runs the debug binary.
	@make debug
	./out/app

clean: ## Deletes all build artifacts.
	rm -rf ./out

help: ## Prints available commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
