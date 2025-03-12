-----------------------------------------------------------
-- Initial setup and package management
-----------------------------------------------------------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local map = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true }

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Package manager
  { "wbthomason/packer.nvim" }, -- Keep packer for potential rollback

  -- File navigation
  {
    "stevearc/oil.nvim",
    opts = {},
    event = "VimEnter",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    -- cmd = "Telescope",
    config = function()
      require("telescope").setup()
      require("telescope").load_extension("fzf")
    end,
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "p00f/clangd_extensions.nvim", lazy = true },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = true,
  },

  -- AI integration
  {
    "zbirenbaum/copilot.lua",
    -- event = "InsertEnter",
    config = function()
      require("copilot").setup({ suggestion = { auto_trigger = true } })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = "CopilotChat",
    config = true,
  },

  -- Syntax and language tools
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        incremental_selection = { enable = false },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "cespare/vim-toml",
    ft = "toml",
  },
  {
    "mechatroner/rainbow_csv",
    ft = "csv",
  },

  -- Editing enhancements
  {
    "jiangmiao/auto-pairs",
  },
  {
    "tpope/vim-surround",
    keys = { "cs", "ds", "ys" },
  },
  {
    "tpope/vim-repeat",
    lazy = true, -- Loaded automatically by keymaps
  },
  {
    "mhinz/vim-signify",
    event = "BufReadPre",
  },
  {
    "junegunn/vim-easy-align",
    keys = { { "ga", mode = { "n", "v" } } },
  },
  {
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = true,
  },

  -- UI and themes
  {
    "morhetz/gruvbox",
    lazy = false, -- Load immediately for proper colorscheme setup
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },

  -- Version control
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
  {
    "urbainvaes/vim-ripple",
    keys = "<C-Y>",
  },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- cmd 'packadd packer.nvim'
-- require('packer').startup(function(use)
--   use 'wbthomason/packer.nvim'
-- 
--   -- File navigation
--   use 'stevearc/oil.nvim'
--   use { 'nvim-telescope/telescope.nvim', requires = {
--     'nvim-lua/popup.nvim',
--     'nvim-lua/plenary.nvim',
--     'nvim-telescope/telescope-fzf-native.nvim'
--   }}
-- 
--   -- LSP and completion
--   use 'neovim/nvim-lspconfig'
--   use 'hrsh7th/nvim-cmp'
--   use 'hrsh7th/cmp-nvim-lsp'
--   use 'hrsh7th/cmp-buffer'
--   use 'hrsh7th/cmp-path'
--   use 'f3fora/cmp-spell'
--   use 'p00f/clangd_extensions.nvim'
--   use 'ray-x/lsp_signature.nvim'
-- 
--   -- AI integration
--   use 'zbirenbaum/copilot.lua'
--   use 'CopilotC-Nvim/CopilotChat.nvim'
-- 
--   -- Syntax and language tools
--   use 'nvim-treesitter/nvim-treesitter'
--   use 'nvim-treesitter/playground'
--   use 'cespare/vim-toml'
--   use 'mechatroner/rainbow_csv'
-- 
--   -- Editing enhancements
--   use 'jiangmiao/auto-pairs'
--   use 'tpope/vim-surround'
--   use 'tpope/vim-repeat'
--   use 'mhinz/vim-signify'
--   use 'junegunn/vim-easy-align'
--   use 'mhartington/formatter.nvim'
-- 
--   -- UI and themes
--   use 'morhetz/gruvbox'
--   use 'sindrets/diffview.nvim'
-- 
--   -- Version control
--   use 'tpope/vim-fugitive'
--   use 'urbainvaes/vim-ripple'
-- end)

-----------------------------------------------------------
-- General settings
-----------------------------------------------------------
g.mapleader = ' '
g.maplocalleader = '\\'
g.python3_host_prog = 'python3'

-- Editor options
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = 'unnamedplus'

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Window management
opt.splitbelow = true
opt.splitright = true

-- File handling
opt.hidden = true
opt.swapfile = false
opt.updatetime = 100

-----------------------------------------------------------
-- Key mappings
-----------------------------------------------------------
-- General shortcuts
map('n', '<leader>e', '<cmd>edit .<CR>', key_opts)
map('n', '<C-s>', '<cmd>w<CR>', key_opts)
map('i', '<C-s>', '<cmd>w<CR>', key_opts)
map('i', 'jk', '<ESC>', key_opts)

-- Tab management
map('n', '<C-t>', '<cmd>tabnew<CR>', key_opts)
map('n', 'tt', ':tabedit<space>', key_opts)
map('n', 'tw', '<cmd>tabclose<CR>', key_opts)
map('n', 'th', '<cmd>tabprev<CR>', key_opts)
map('n', 'tl', '<cmd>tabnext<CR>', key_opts)

-- Telescope navigation
map('n', '<leader>f', '<cmd>Telescope find_files<CR>', key_opts)
map('n', '<leader>b', '<cmd>Telescope buffers<CR>', key_opts)
map('n', '<leader>m', '<cmd>Telescope oldfiles<CR>', key_opts)
map('n', '<leader>p', '<cmd>Telescope live_grep<CR>', key_opts)
map('n', '<leader>s', '<cmd>Telescope grep_string<CR>', key_opts)
map('n', '<leader>t', '<cmd>Telescope treesitter<CR>', key_opts)

-- Ripple REPL integration
map('n', '<C-Y>', '<Plug>(ripple_send_line)', { silent = true })
map('i', '<C-Y>', '<C-O><C-Y>', { silent = true })
map('v', '<C-Y>', '<Plug>(ripple_send_selection)', { silent = true })
map('n', '<leader>y', 'yrap', { silent = true })

-----------------------------------------------------------
-- Plugin configurations
-----------------------------------------------------------
-- Oil.nvim file explorer
require('oil').setup({
  win_options = {
    winbar = '%!v:lua.get_oil_winbar()'
  },
  cleanup_delay_ms = false
})

-- Treesitter syntax parsing
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  playground = { enable = true },
  incremental_selection = { enable = true }
})

-- LSP setup
local lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { 'utf-16' }

local on_attach = function(client, bufnr)
  local buf_map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  buf_map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
  buf_map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', 'Goto definition')
  buf_map('n', 'gr', '<cmd>Telescope lsp_references<CR>', 'Show references')
  buf_map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
  buf_map('n', '<space>rn', vim.lsp.buf.rename, 'Rename symbol')
  buf_map('n', '<space>q', vim.lsp.buf.code_action, 'Code actions')
end

-- Language servers
lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--malloc-trim"},
  capabilities = capabilities,
}
lsp.pylsp.setup {
    on_attach = on_attach,
    filetypes = {'python'},
    settings = {
        configurationSources = {"flake8"},
        formatCommand = {"black"},
        pylsp = {
            plugins = {
            -- jedi_completion = {fuzzy = true},
            -- jedi_completion = {eager=true},
            jedi_completion = {
                include_params = true,
            },
            jedi_signature_help = {enabled = true},
            pyflakes={enabled=true},
            -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
            pylsp_mypy={enabled=false},
            pycodestyle={
                enabled=true,
                ignore={'E501', 'E231'},
                maxLineLength=120},
                yapf={enabled=true}
            }
        }
    }
}
lsp.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
lsp.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Completion (nvim-cmp)
local cmp = require'cmp'
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
        ['<C-e>'] = cmp.mapping.abort()
    }),
    sources = cmp.config.sources(
    {
      { name = 'nvim_lsp', priority = 8 },
    }, 
    {
      { name = 'path' }
    },
    {
      { name = 'buffer' },
    }
    ),
    experimental = {
        ghost_text = false
    },
    completion = { 
        autocomplete = false
    },
    preselect = cmp.PreselectMode.None
  }
)

-- Copilot AI integration
require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<C-CR>"
    },
    layout = {
      position = "right", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-E>",
      accept_word = false,
      accept_line = false,
      next = "<C-]>",
      prev = "<C-[>",
      dismiss = "<C-.>",
    },
  },
  filetypes = {
    markdown = true,
    gitcommit = true,
    gitrebase = true,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

-----------------------------------------------------------
-- UI customization
-----------------------------------------------------------
cmd 'colorscheme gruvbox'
cmd 'augroup tmux | au VimEnter * hi! Normal guibg=none | augroup END'

-- Status line customization
function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  return dir and vim.fn.fnamemodify(dir, ':~') or vim.api.nvim_buf_get_name(0)
end

function _G.statusline()
  return '%<%f ' .. require('lsp_signature').status_line(10000).hint
end

cmd [[set statusline=%!v:lua.statusline()]]
