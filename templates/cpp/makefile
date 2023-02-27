# ----------- #
#  Variables  #
# ----------- #

CXXFLAGS = -Wall -Wextra --stdlib=libc++ --std=c++17 -Wno-unused-parameter -Wno-unused-function

RELEASE_FLAGS = -O2 -D NDEBUG
DEBUG_FLAGS = -D DEBUG

# --------------- #
#  Phony Targets  #
# --------------- #

all: ## Builds both the release and debug binaries.
	@make debug
	@make release

release: ## Builds the release binary.
	@mkdir -p out/release
	@printf "\e[1;32mBuilding\e[0m out/release/app (release)\n"
	@$(CXX) $(CXXFLAGS) $(RELEASE_FLAGS) -o out/release/app src/*.cpp

debug: ## Builds the debug binary.
	@mkdir -p out/debug
	@printf "\e[1;32mBuilding\e[0m out/debug/app (debug)\n"
	@$(CXX) $(CXXFLAGS) $(DEBUG_FLAGS) -o out/debug/app src/*.cpp

run: ## Builds and runs the debug binary.
	@make debug
	./out/debug/app

clean: ## Deletes all build artifacts.
	rm -rf ./out

help: ## Prints available commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
