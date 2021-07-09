# language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# zplug
if [ "$(uname)" = "Darwin" ]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
else
  export ZPLUG_HOME=$HOME/.zplug
fi

source $ZPLUG_HOME/init.zsh

zplug "agkozak/zsh-z"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "sobolevn/wakatime-zsh-plugin"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "jeffreytse/zsh-vi-mode"

if ! zplug check; then
  printf "Install zsh plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# common
export EDITOR='nvim'
export TERM=xterm-256color
KEYTIMEOUT=1

# cd -
setopt AUTOPUSHD

# history
# set history size
export HISTSIZE=10000
# save history after logout
export SAVEHIST=10000
# history file
export HISTFILE=~/.zsh_history
# append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS

# make search up and down work, so partially type and hit up/down to find relevant stuff
# todo: refresh zsh-syntax-highlighting
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# homebrew completion
if [ "$(uname)" = "Darwin" ]; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# zsh-z
autoload -U compinit && compinit
zstyle ':completion:*' menu select
export ZSHZ_CASE=smart

# smart-case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# p10k configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# use neovim
alias 'vim'='nvim'

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # macOS `ls`
  colorflag="-G"
fi

# List all files colorized in long format, excluding . and ..
alias ll="ls -lhF ${colorflag}"
# List only directories
alias ld="ls -lhF ${colorflag} | grep --color=never '^d'"

# https://unix.stackexchange.com/questions/141367/have-xargs-use-alias-instead-of-binary
alias xargs="xargs "

# bindkey
bindkey -v
# bindkey "^P" up-line-or-beginning-search
# bindkey "^N" down-line-or-beginning-search
# todo: OSX $key and $terminfo values are both wrong, so hardcode
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# fzf key bindings and fuzzy completion
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
zvm_after_init_commands+=('source /usr/share/doc/fzf/examples/key-bindings.zsh')
zvm_after_init_commands+=('source /usr/share/doc/fzf/examples/completion.zsh')
zvm_after_init_commands+=('bindkey "^P" up-line-or-beginning-search')
zvm_after_init_commands+=('bindkey "^N" down-line-or-beginning-search')

# local config
[[ -f $HOME/.local/.zshrc.local ]] && source $HOME/.local/.zshrc.local
