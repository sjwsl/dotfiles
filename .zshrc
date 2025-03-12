# ======================
# 1. Environment Variables and Basic Settings
# ======================

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Editor and terminal settings
export EDITOR='nvim'
export TERM=xterm-256color
KEYTIMEOUT=1

# History configuration
export HISTSIZE=100000000
export SAVEHIST=100000000
export HISTFILESIZE=1000000000
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# Automatically push directories to the stack
setopt AUTOPUSHD

# ======================
# 2. Zplug Plugin Manager
# ======================

# Set Zplug path
if [ "$(uname)" = "Darwin" ]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
else
  export ZPLUG_HOME=$HOME/.zplug
fi

# Initialize Zplug
source $ZPLUG_HOME/init.zsh

# Plugin list
zplug "agkozak/zsh-z"  # Quick directory navigation
zplug "romkatv/powerlevel10k", as:theme, depth:1  # Theme
zplug "zsh-users/zsh-autosuggestions", defer:2  # Autosuggestions
zplug "zsh-users/zsh-syntax-highlighting", defer:3  # Syntax highlighting

# Check and install plugins if missing
if ! zplug check; then
  printf "Install zsh plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Load plugins
zplug load

# ======================
# 3. Powerlevel10k Configuration
# ======================

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ======================
# 4. Completion and Autoload
# ======================

# Initialize completion system
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -C -i  # Skip security checks for faster initialization
fi

# Completion menu and smart case matching
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# zsh-z configuration
export ZSHZ_CASE=smart

# ======================
# 5. Aliases and Key Bindings
# ======================

# Use Neovim
alias vim='nvim'
alias nvimdiff='nvim -d'

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# ls configuration
if ls --color > /dev/null 2>&1; then
  colorflag="--color"
else
  colorflag="-G"
fi
alias ll="ls -lhF ${colorflag}"
alias ld="ls -lhF ${colorflag} | grep --color=never '^d'"

# xargs alias
alias xargs="xargs "

# Key bindings
bindkey -e
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
bindkey '^x^e' edit-command-line
bindkey -s '^.' 'cd ..\n'
bindkey -s '^,' 'cd -\n'

# ======================
# 6. FZF Configuration
# ======================

# Load FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--layout reverse --height 10% -m --bind ctrl-s:toggle,ctrl-a:toggle-all --history $HOME/.fzf_history"

# ======================
# 7. Local and Path Configuration
# ======================

# Load local configuration file
[[ -f $HOME/.local/.zshrc.local ]] && source $HOME/.local/.zshrc.local

# Custom paths
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/home/tianshu/work/dfs_sh_client/libs"
export PYTHONPATH=$PYTHONPATH:"/home/tianshu/work/dfs_sh_client"
export PATH="/usr/lib/ccache:$PATH"

# ======================
# 8. Conda Configuration (Lazy Load)
# ======================

lazy_conda() {
  unset -f lazy_conda
  # >>> conda initialize >>>
  __conda_setup="$('/home/tianshu/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/tianshu/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/home/tianshu/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/tianshu/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}
conda() { lazy_conda; conda "$@"; }

# ======================
# 9. Miscellaneous Configuration
# ======================

# Enable zprof for profiling (uncomment for debugging)
# zmodload zsh/zprof
