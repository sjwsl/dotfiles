#!/usr/bin/env zsh

function sync() {
	rsync --exclude ".git/" \
			--exclude ".DS_Store" \
			--exclude "bootstrap.sh" \
			--exclude "README.md" \
			-avh --no-perms . ~

	source ~/.zshrc

	tmux source-file ~/.tmux.conf 

  nvim -c 'PlugInstall|q|q'
}

function mac_init() {
	if ! [ -x "$(command -v brew)" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew update
	brew install coreutils
	brew install git
	brew install zplug
	brew install neovim
	brew install tmux
}

function linux_init() {
  # install zplug
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  suto apt update
  sudo apt install -y coreutils
  sudo apt install -y git
  sudo apt install -y neovim
  sudo apt install -y tmux
}

function init() {
  if [ "$(uname)" = "Darwin" ]; then
    mac_init
  else
    linux_init
  fi

  # install vim-plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

if [ "$1" = "--init" ] || [ "$1" = "-i" ]; then
	init
fi

sync

unset brew sync init mac_init
