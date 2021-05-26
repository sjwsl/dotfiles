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

if ! zplug check; then
  printf "Install zsh plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# common
export EDITOR='vim'
export TERM=xterm-256color

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
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# zsh-z
autoload -U compinit && compinit
zstyle ':completion:*' menu select
export ZSHZ_CASE=smart

# smart-case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# p10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# alias
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

# fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bindkey
bindkey -v
bindkey "$key[Up]" up-line-or-beginning-search
bindkey "$key[Down]" down-line-or-beginning-search
# todo: OSX $key and $terminfo values are both wrong, so hardcode
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup

export PATH="$HOME/anaconda3/bin/:$PATH"
# <<< conda initialize <<<
