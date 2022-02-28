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
  
  use 'ervandew/supertab'
  use 'Chiel92/vim-autoformat'
  use 'Junegunn/vim-easy-align'
  use 'mhinz/vim-signify'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'wakatime/vim-wakatime'
  use 'Olical/conjure'
  use 'jiangmiao/auto-pairs'

end)

cmd 'colorscheme gruvbox'
cmd 'augroup tmux | au VimEnter * hi! Normal guibg=none | augroup END'          -- Diffrent background in inactive tmux pane
g.mapleader = " "
g.maplocalleader = "\\"
opt.completeopt = { 'menuone', 'longest', 'noselect' }   -- Completion options
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
opt.mouse = 'a'                     -- Enable mouse
opt.swapfile = false                -- Disable swap
g['netrw_banner'] = 0
g['netrw_liststyle'] = 3
g['SuperTabDefaultCompletionType'] = "<c-x><c-o>"

map('i', 'jk', '<esc>', ns)
map('', 'cp', '"+y', ns)
map('n', '<leader>e', '<cmd>edit .<CR>', ns)

require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', highlight = { enable = true }
}

local lsp = require 'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy" }
}

lsp.pylsp.setup{
  on_attach = on_attach
}

lsp.gopls.setup{
  on_attach = on_attach
}

lsp.eslint.setup{
  on_attach = on_attach
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
