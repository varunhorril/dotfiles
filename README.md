# dotfiles

Setup for [Homebrew](https://brew.sh) packages and my personal dotfiles. Works on *nix, optimized for macOS.

## About

### Installing

```sh
make
```

This will create symlinks from this repository to your home directory.

### Customizing

Save env vars, etc in a `.extra` file that looks something like this:

```sh
###
### Git credentials
###

GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="email@you.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

GH_USER="nickname"
git config --global github.user "$GH_USER"
```
