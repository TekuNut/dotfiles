vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gd",
  callback = function()
    vim.bo.filetype = "gdscript"
  end,
})
