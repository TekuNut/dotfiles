-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Start nvim server
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.uv.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end

-- Setup LSP
local lspconfig = require("lspconfig")
lspconfig.gdscript.setup({})

-- Configure file type extensions
vim.filetype.add({
  pattern = {
    ["*.gd"] = "gdscript",
  },
})
