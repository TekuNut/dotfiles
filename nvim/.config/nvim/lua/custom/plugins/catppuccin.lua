return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      dap = true,
      dap_ui = true,
      gitsigns = true,
      mason = true,
      mini = {
        enabled = true,
        identscope_color = '',
      },
      treesitter = true,
      telescope = { enabled = true },
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    vim.cmd.colorscheme 'catppuccin'
  end,
}
