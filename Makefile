default: all

# Help message
help:
	@echo
	@echo "Target rules:"
	@echo "    all       - Restores, lints, compiles and generates the application"
	@echo "    bootstrap - Bootstraps developer environment"
	@echo "    restore   - Restores dependencies"
	@echo "    build     - Compiles the application"
	@echo "    lints     - Lints the repository"
	@echo "    clean     - Clean the project"
	@echo "    help      - Prints a help message with target rules"

all: restore lint build

bootstrap:
	git submodule sync --recursive && git submodule update --init --recursive
	arch -arm64 brew install pre-commit && arch -arm64 brew upgrade pre-commit
	arch -arm64 brew install npm && arch -arm64 brew upgrade npm
	arch -arm64 brew install yarn && arch -arm64 brew upgrade yarn
	arch -arm64 brew install swiftformat && arch -arm64 brew upgrade swiftformat
	arch -arm64 brew install carthage && arch -arm64 brew upgrade carthage
	arch -arm64 brew install fastlane && arch -arm64 brew upgrade fastlane
	arch -arm64 sudo gem install bundler
	arch -arm64 pre-commit install
	arch -arm64 pre-commit autoupdate
	arch -arm64 pre-commit run

restore:
	arch -arm64 carthage bootstrap
	cd browser-extension && yarn install && cd ..

build:
	arch -arm64 carthage build
	arch -arm64 bundle exec fastlane
	cd browser-extension && yarn install && cd ..

lint:
	arch -arm64 pre-commit run


# Rule for cleaning the project
clean:
	@rm -rvf helloworld *.o
