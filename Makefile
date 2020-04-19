.PHONY: all
all:  ## installs the bin and the dotfiles.
	 setup bin dotfiles

.PHONY: bin
bin: ## install the bin directory files
	for file in $(shell find $(CURDIR)/bin -type f -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$ff; \
	done

.PHONY: setup
setup: ## setup homebrew, starship bash prompt & vim

	# install homebrew & homebrew packages
	(sudo xcode-select --install && \
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | sh && \
	brew bundle)

	# install vimrc & vim-airline
	(git clone --depth=1 https://github.com/amix/vimrc.git $(HOME)/.vim_runtime && \
	git clone https://github.com/vim-airline/vim-airline.git $(HOME)/.vim_runtime/my_plugins/vim_airline && \
	sh $(HOME)/.vim_runtime/install_awesome_vimrc.sh)

	# install the starship prompt for bash
	curl -fsSL https://starship.rs/install.sh | bash;
	mkdir -p ~/.config && cp .config/starship.toml ~/.config

.PHONY: dotfiles
dotfiles: ## install the dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".github" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

help:   ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
