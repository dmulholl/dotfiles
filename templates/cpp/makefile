# ----------- #
#  Variables  #
# ----------- #

CXXFLAGS = -Wall -Wextra --stdlib=libc++ --std=c++11 -Wno-unused-parameter -Wno-unused-function

RELEASE_FLAGS = -O3 -D NDEBUG
DEBUG_FLAGS = -D DEBUG

# --------------- #
#  Phony Targets  #
# --------------- #

debug: ## Builds the debug binary.
	@mkdir -p out
	@printf "\e[1;32mBuilding\e[0m out/app (debug)\n"
	@$(CXX) $(CXXFLAGS) $(DEBUG_FLAGS) -o out/app src/*.cpp

release: ## Builds the release binary.
	@mkdir -p out
	@printf "\e[1;32mBuilding\e[0m out/app (release)\n"
	@$(CXX) $(CXXFLAGS) $(RELEASE_FLAGS) -o out/app src/*.cpp

run: ## Builds and runs the debug binary.
	@make debug
	./out/app

clean: ## Deletes all build artifacts.
	rm -rf ./out

help: ## Prints available commands.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / \
	{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
