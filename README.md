# github_dark.nvim

Colorscheme inspired by GitHub's light and dark themes.

Supports:
* Neovim via lua
* Shell via ANSI escape codes.

## Installation (neovim)

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {'lewis6991/github_dark.nvim'}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'lewis6991/github_dark.nvim'
```

The colorscheme follows Neovim's `'background'` option. To follow the terminal
appearance, load it without setting `'background'` explicitly:

```vim
colorscheme github_dark
```

Neovim detects appearance changes when the terminal supports them and reloads
the colorscheme with the matching palette. To select one manually instead:

```vim
set background=light
```

Setting `'background'` explicitly disables automatic detection.

## Installation (shell, dark only)

Clone the repo somewhere:

```bash
git clone https://github.com/lewis6991/github_dark.nvim
```

Add this to one of your shell RC files, e.g. `~/.profile`:

```bash
<path to github_dark>/theme.sh
```
