local cmd = vim.cmd

cmd 'packadd packer.nvim'

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
end)

local lsp = require 'lspconfig'

lsp.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy" }
}
