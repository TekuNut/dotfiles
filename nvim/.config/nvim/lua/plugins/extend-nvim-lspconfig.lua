return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Enable godot LSP
    lspconfig.gdscript.setup(capabilities)
  end,
}
