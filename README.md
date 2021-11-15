# dotfiles

<img width="2560" alt="Screenshot 2021-05-13 at 17 04 39" src="https://user-images.githubusercontent.com/44310559/118104159-5a731c80-b40d-11eb-9658-bbf3fdac4dbb.png">

This is my personal Unix dotfiles including
- zsh
- tmux
- neovim
- git
- ...

Tested on
- macOS Big Sur
- Ubuntu 20.04 (except iTerm2 stuffs)

Should work on recent releases of macOS and Ubuntu.

## Installation

```zsh
git clone https://github.com/sjwsl/dotfiles
cd dotfiles
zsh ./bootstrap.sh --init
```

This will install dependencies and copy configuration files to the right place.

## Customization

Modify the configuration in `dotfiles` then

```zsh
./bootstrap.sh
```

to apply the changes without initialization.

Or if you want local/experimental changes, create a corresponding file in `$HOME/.local/`. Currently only `.zsh.local` and `.gitconfig.local` are supported.

## Main features

- Full set of [gruvbox-dark](https://github.com/morhetz/gruvbox) theme (iTerm2, zsh, tmux, vim)
- Minimal Zsh configuration with some useful tools installed
- More comfortable tmux key bindings
- Neovim configuration using pure Lua with powerful C++ support and basic support for other languages (thanks to the awesome plugins)

## Thanks to

- [zplug](https://github.com/zplug/zplug)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [tpm](https://github.com/tmux-plugins/tpm)
- [gruvbox](https://github.com/morhetz/gruvbox)

## TODO

- [ ] Platform-specific configurations (currently mainly focused on macOS)
- [ ] Better compatibility
- [ ] Fewer plugin dependencies (long term)
- [ ] More concise vim configuration
- [ ] Option for bootstrap to install extra tools
- [x] Support more local configuration
