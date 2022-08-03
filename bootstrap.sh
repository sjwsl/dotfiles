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
}

function mac_init() {
  if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew update
  brew install coreutils \
               git \
               neovim \
               tmux \
               cmake \
               curl \
               fzf \
               node \
               npm \
               python3 \
               rsync \
               yarn \
               zsh \
               ripgrep \
               fd \
               bat

  open ./Gruvbox.itermcolors

  # To install useful key bindings and fuzzy completion:
  $(brew --prefix)/opt/fzf/install
}

function linux_init() {
  sudo apt update

  sudo apt install -y cmake \
                      coreutils \
                      curl \
                      git \
                      global \
                      neovim \
                      nodejs \
                      npm \
                      pip \
                      python \
                      rsync \
                      tmux \
                      yarn \
                      zsh \
                      fd-find \
                      bat \
                      fzf \
                      locales \
                      ripgrep

  sudo locale-gen en_US.UTF-8
  sudo locale-gen zh_CN.UTF-8

  # zplug
  rm -rf $HOME/.zplug
  git clone https://github.com/zplug/zplug $HOME/.zplug

  # fd
  ln -s $(which fdfind) ~/.local/bin/fd
}

function init() {
  if [ "$(uname)" = "Darwin" ]; then
    mac_init
  else
    linux_init
  fi

  # packer.nvim
  git clone https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

  # tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # wakatime
  # pip install wakatime
  # sudo ln -s $HOME/.local/bin/wakatime /usr/local/bin/wakatime
}

if [ "$1" = "--init" ] || [ "$1" = "-i" ]; then
  init
fi

sync

unset brew sync init mac_init linux_init
