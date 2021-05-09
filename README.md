# dotfiles

<img width="2560" alt="Screenshot 2021-05-07 at 18 27 27" src="https://user-images.githubusercontent.com/44310559/117436729-e4306f00-af61-11eb-9131-952c88f2bd64.png">

This is my personal Unix dotfiles including
- zsh
- tmux
- neovim
- ...

Tested on
- macOS Big Sur
- Ubuntu 20.04 LTS

## Installation

```zsh
git clone https://github.com/sjwsl/dotfiles
cd dotfiles
zsh ./bootstrap.sh --init
```

## Dependencies

- [zplug](https://github.com/zplug/zplug) for managing zsh plugins
- [vim-plug](https://github.com/junegunn/vim-plug) for managing vim plugins
- [tpm](https://github.com/tmux-plugins/tpm) for managing tmux plugins
