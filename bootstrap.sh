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
  brew install zsh
	brew install coreutils
	brew install git
	brew install neovim
	brew install tmux
  brew install fzf
}

function linux_init() {
  sudo apt update
  sudo apt install -y zsh
  sudo apt install -y coreutils
  sudo apt install -y git
  sudo apt install -y neovim
  sudo apt install -y tmux
  sudo apt-get install -y fzf

  # zplug
  rm -rf $HOME/.zplug
  git clone https://github.com/zplug/zplug $HOME/.zplug
}

function init() {
  if [ "$(uname)" = "Darwin" ]; then
    mac_init
  else
    linux_init
  fi

  # vim-plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

if [ "$1" = "--init" ] || [ "$1" = "-i" ]; then
	init
fi

sync

unset brew sync init mac_init linux_init
