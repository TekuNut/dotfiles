return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      -- Show a single statusline
      globalstatus = true,
      disabled_filetypes = {
        statusline = { 'dashboard', 'ministarter' },
        winbar = { 'dashboard', 'ministarter', 'NVimTree', 'dap-view', 'dap-repl', 'dap-disassembly' },
      },
    },
    winbar = {
      lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
    },
    inactive_winbar = {
      lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
    },
  },
}
