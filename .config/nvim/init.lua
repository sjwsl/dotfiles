local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local map = vim.api.nvim_set_keymap
local n = { noremap = true }
local ns = { noremap = true, silent = true }
local s = { silent = true }

cmd 'packadd packer.nvim'

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }

  use 'Chiel92/vim-autoformat'
  use 'Junegunn/vim-easy-align'
  use 'Olical/conjure'
  -- use 'ervandew/supertab'
  use 'github/copilot.vim'
  use 'jiangmiao/auto-pairs'
  use 'lervag/vimtex'
  use 'mhinz/vim-signify'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'p00f/clangd_extensions.nvim'
  use 'ray-x/lsp_signature.nvim'
  use "hrsh7th/nvim-cmp" --completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
end)

local tabnine = require('cmp_tabnine.config')

local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {"i", "s"}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end, {"i", "s"}),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', priority = 8 },
      { name = 'cmp_tabnine', priority = 9 }
    }, {
      { name = 'buffer' },
    }),
    experimental = {
        ghost_text = false
    },
    completion = { 
	autocomplete = false
    }
  }
  )

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


tabnine.setup({
	max_lines = 1000,
	max_num_results = 1,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
	ignored_file_types = { 
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
	show_prediction_strength = false
})

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
opt.shiftwidth = 4                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.mouse = 'a'                     -- Enable mouse
opt.swapfile = false                -- Disable swap
opt.updatetime = 0                  -- Update time in milliseconds
g['netrw_banner'] = 0
g['netrw_liststyle'] = 3
-- g['SuperTabDefaultCompletionType'] = "<c-x><c-o>"
g['formatdef_latexindent'] = '"latexindent -"'
g['copilot_no_tab_map'] = true
g['copilot_assume_mapped'] = true

map('i', 'jk', '<esc>', ns)
map('', 'cp', '"+y', ns)
map('n', '<leader>e', '<cmd>edit .<CR>', ns)
map('n', '<C-s>', '<cmd>w<CR>', n)
map('i', '<C-s>', '<cmd>w<CR>', n)

require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true }
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
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- Fix "multiple clients with different offset encodings" error
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

require "lsp_signature".setup {
  floating_window = false,
  hint_enable = false,
}

current_signature = function()
  if not pcall(require, 'lsp_signature') then return end
  local sig = require("lsp_signature").status_line(10000)
  return sig.hint
end

get_filename = function()
  return "%<%f "
end

statusline = function()
  return get_filename() .. current_signature()
end

vim.api.nvim_exec([[set statusline=%!v:lua.statusline()]], false)

lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  capabilities = capabilities,
}

lsp.pylsp.setup {
  on_attach = on_attach
}

lsp.gopls.setup {
  on_attach = on_attach
}

lsp.eslint.setup {
  on_attach = on_attach
}

lsp.rust_analyzer.setup {
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
map('i', '<C-E>', 'copilot#Accept("")', {expr=true, silent=true})

map('n', '<c-t>', '<cmd>tabnew<cr>', ns)
map('n', 'tt', ':tabedit<space>', n)
map('n', 'tw', '<cmd>tabclose<cr>', ns)
map('n', 'th', '<cmd>tabprev<cr>', ns)
map('n', 'tl', '<cmd>tabnext<cr>', ns)
map('n', '<leader>1', '1gt', ns)
map('n', '<leader>2', '2gt', ns)
map('n', '<leader>3', '3gt', ns)
map('n', '<leader>4', '4gt', ns)
map('n', '<leader>5', '5gt', ns)
map('n', '<leader>6', '6gt', ns)
map('n', '<leader>7', '7gt', ns)

-- TODO
-- spellcheck
-- tmux panes
-- specify path in file fuzzy finder
-- toggle hlsearsh
