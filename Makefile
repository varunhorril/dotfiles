SHELL := bash

export PATH := bin:$(PATH)

.DEFAULT_GOAL := setup

setup: install bin dotfiles # Install packages, bin files and dotfiles

.PHONY: bin
bin: ## Install the bin directory files
	@for file in $(shell find $(CURDIR)/bin -type f -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

dotfiles: # Install dotfiles
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".editorconfig" -not -name ".config" -not -name ".git" -not -name ".gitignore" -not -name ".github" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done \

	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	mkdir -p $(HOME)/.config;
	ln -snf $(CURDIR)/.config/mpv $(HOME)/.config/mpv;
	ln -snf $(CURDIR)/.config/nvim $(HOME)/.config/nvim;
	ln -snf $(CURDIR)/.config/starship.toml $(HOME)/.config/starship.toml;

.PHONY: install
install: ## Install Homebrew packages, starship and poetry
	# check if command line tools are installed
	@[ -f "/Library/Developer/CommandLineTools/usr/bin/git" ] || xcode-select --install;

	# check if Homebrew is installed
	@if [ -f "/usr/local/bin/brew" ] || [ -f "/opt/homebrew/bin/brew" ]; then \
		(/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"); \
		brew bundle; \
	fi

	# install starship (bash prompt)
	curl -fsSL https://starship.rs/install.sh | sh;

	# install poetry (python dependency manager)
	curl -sSL https://install.python-poetry.org | python3 -

.PHONY: test
test: shellcheck ## Run shellcheck on all the scripts in the repo
	# if this session isn't interactive, then we don't want to allocate a
	# TTY, which would fail, but if it is interactive, we do want to attach
	# so that the user can send e.g. ^C through
	INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
	ifeq ($(INTERACTIVE), 1)
		DOCKER_FLAGS += -t
	endif

shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
	--name df-shellcheck \
	-v $(CURDIR):/usr/src:ro \
	--workdir /usr/src \
	jess/shellcheck ./test.sh


help: ## Show the help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
