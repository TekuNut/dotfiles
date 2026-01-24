-- Native LSP configuration

return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
    vim.lsp.enable({
      "clangd",
      "lua_ls",
      "zls"
    })
  end
}
