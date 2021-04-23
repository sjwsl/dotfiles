#!/usr/bin/env zsh

function sync() {
	rsync --exclude ".git/" \
			--exclude ".DS_Store" \
			--exclude "bootstrap.sh" \
			--exclude "README.md" \
			-avh --no-perms . ~

	source ~/.zshrc
	tmux source-file ~/.tmux.conf 
}

function init() {
	if ! [ -x "$(command -v brew)" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew update

	brew install coreutils
	brew install git
	brew install zplug
	brew install neovim
	brew install tmux

	sync
}

if [ "$1" = "--init" ] || [ "$1" = "-i" ]; then
	init
else
	sync
fi

unset brew sync init
