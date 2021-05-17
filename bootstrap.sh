#!/usr/bin/env zsh

function sync() {
	rsync --exclude ".git/" \
			--exclude ".DS_Store" \
			--exclude "bootstrap.sh" \
			--exclude "README.md" \
      --exclude "LICENSE" \
      --exclude "Gruvbox.itermcolors" \
			-avh --no-perms . ~
  
	tmux source-file ~/.tmux.conf 

  nvim -c 'PlugInstall|CocInstall|qa'

  zsh
}

function mac_init() {
	if ! [ -x "$(command -v brew)" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew update
  brew install python3
  brew install npm
  brew install yarn
  brew install node
  brew install rsync
  brew install curl
  brew install zsh
	brew install coreutils
	brew install git
	brew install neovim
	brew install tmux
  brew install fzf

  open ./Gruvbox.itermcolors
}

function linux_init() {
  if ! [ -x "$(command -v sudo)" ]; then
    apt update
    apt install sudo
  else
    sudo apt update
  fi

  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

  sudo apt install -y python
  sudo apt install -y pip
  sudo apt install -y global
  sudo apt install -y npm
  sudo apt install -y yarn
  sudo apt install -y nodejs
  sudo apt install -y rsync
  sudo apt install -y curl
  sudo apt install -y zsh
  sudo apt install -y coreutils
  sudo apt install -y git
  sudo apt install -y neovim
  sudo apt install -y tmux
  sudo apt-get install -y ripgrep
  sudo apt-get install -y locales
  sudo apt-get install -y fzf

  sudo locale-gen en_US.UTF-8 
  sudo locale-gen zh_CN.UTF-8

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
