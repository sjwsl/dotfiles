local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local map = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }
local s = { silent = true }

cmd 'packadd packer.nvim'

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }

  use 'nvim-lua/completion-nvim'
  use 'Chiel92/vim-autoformat'
  use 'Junegunn/vim-easy-align'
  use 'mhinz/vim-signify'
  use 'vim-airline/vim-airline'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

end)

cmd 'colorscheme gruvbox'
cmd 'hi! Normal guibg=none'          -- For diffrent background in inactive tmux pane
g.mapleader = " "
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }  -- Completion options
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wrap = false                    -- Disable line wrap
opt.mouse = 'a'
opt.swapfile = false
g['netrw_banner'] = 0
g['netrw_liststyle'] = 3

map('i', 'jk', '<esc>', ns)
map('n', '<C-W>|', '<cmd>vsplit<CR>', ns)
map('n', '<C-W>_', '<cmd>split<CR>', ns)
map('', 'cp', '"+y', ns)
map('n', '<leader>e', '<cmd>edit .<CR>', ns)

g['airline#extensions#whitespace#enabled'] = 0
g['airline#extensions#scrolbar#enabled'] = 0

require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', highlight = { enable = true }
}

local lsp = require 'lspconfig'

lsp.clangd.setup {
  cmd = { "clangd", "--background-index", "--clang-tidy" }
}

require 'telescope'.setup(
{
  defaults = {
    extensions = {
      fzf = {
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      }
    }
  }
}
)
require('telescope').load_extension('fzf')

g['completion_enable_auto_popup'] = 0
map('i', '<tab>', '<plug>(completion_smart_tab)', s)
map('i', '<s-tab>', '<plug>(completion_smart_s_tab)', s)

map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', ns)
map('n', 'gr', '<cmd>Telescope lsp_references<CR>', ns)
map('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', ns)
map('n', 'gs', '<cmd>Lspsaga signature_help<CR>', ns)
map('n', '<leader>q', '<cmd>Lspsaga code_action<CR>', ns)
map('v', '<leader>q', '<cmd><C-U>Lspsaga range_code_action<CR>', ns)
map('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', ns)
map('n', '[g', '<cmd>Lspsaga diagnostic_jump_next<CR>', ns)
map('n', ']g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', ns)

-- Find files using Telescope command-line sugar.
map('n', '<leader>f', '<cmd>Telescope find_files<cr>', ns)
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', ns)
map('n', '<leader>m', '<cmd>Telescope oldfiles<cr>', ns)
map('n', '<leader>p', '<cmd>Telescope live_grep<cr>', ns)
map('n', '<leader>s', '<cmd>Telescope grep_string<cr>', ns)
map('n', '<leader>t', '<cmd>Telescope treesitter<cr>', ns)

-- TODO
-- spellcheck
-- tmux panes
-- specify path in file fuzzy finder
-- toggle hlsearsh
-- telescope performance
-- ctags
