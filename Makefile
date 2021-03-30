SHELL := bash

export PATH := bin:$(PATH)

.DEFAULT_GOAL := setup dotfiles bin

.PHONY: bin
bin: ## Install binaries from the .bin directory to /usr/local/bin
	@for file in $(shell find $(CURDIR)/.bin -type f -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles: ## Install dotfiles
	@for file in $(shell find $(CURDIR) -name ".*" -not -name ".editorconfig" -not -name ".git" -not -name ".gitignore" -not -name ".github" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done

	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	[[ ! -d $(HOME)/.config ]] && mkdir -p $(HOME)/.config;
	ln -snf $(CURDIR)/.config/mpv $(HOME)/.config/mpv;
	ln -snf $(CURDIR)/.config/starship.toml $(HOME)/.config/starship.toml;

.PHONY: setup
setup: ## Install homebrew, starship and configure vim
	# check if x-code is installed
	@[ -f "/usr/bin/xcodebuild" ] || xcode-select --install;

	# check if homebrew is installed && install brew packages
	@[ -f "/usr/local/bin/brew" ] || (curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | sh);
	brew bundle;

	# install vimrc and vim-airline
	git clone --depth=1 https://github.com/amix/vimrc.git $(HOME)/.vim_runtime && \
		git clone https://github.com/vim-airline/vim-airline.git $(HOME)/.vim_runtime/my_plugins/vim_airline && \
		bash $(HOME)/.vim_runtime/install_awesome_vimrc.sh

	# install starship (bash prompt)
	curl -fsSL https://starship.rs/install.sh | bash;

.PHONY: shellcheck
shellcheck: ## Run the shellcheck tests on the scripts
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src r.j3ss.co/shellcheck ./test.sh


.PHONY: test
test: shellcheck ## Run all the tests on the files in the repo
	# if this session isn't interactive, then we don't want to allocate a
	# TTY, which would fail, but if it is interactive, we do want to attach
	# so that the user can send e.g. ^C through
	INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
	ifeq ($(INTERACTIVE), 1)
		DOCKER_FLAGS += -t
	endif

.PHONY: help
help: ## Show this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
