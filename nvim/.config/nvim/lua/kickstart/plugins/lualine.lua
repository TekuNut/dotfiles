return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      -- Show a single statusline
      globalstatus = true,
      disabled_filetypes = {
        statusline = { 'dashboard', 'ministarter' },
        winbar = { 'dashboard', 'ministarter', 'NVimTree' },
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
