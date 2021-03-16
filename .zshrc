# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES='/Users/xutianshu/.dotfiles'

source $DOTFILES/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $DOTFILES/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $DOTFILES/zsh/plugins/zsh-z/zsh-z.plugin.zsh
source $DOTFILES/zsh/alias.zsh

# make zsh completion show hidden files
setopt globdots

# User configuration
export EDITOR='vim'
export TERM=xterm-256color

export PATH="/Users/xutianshu/anaconda3/bin/:$PATH"

# zsh-z
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search                                                
bindkey '^[[B' down-line-or-search

# smart-case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/xutianshu/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/xutianshu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/xutianshu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/xutianshu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

