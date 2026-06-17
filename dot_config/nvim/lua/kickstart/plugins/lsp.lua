return {
  {
    'folke/neoconf.nvim',
    opts = {},
  },
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neoconf.nvim',
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'jsonls',
        'stylua',
      },
    },
  },
}
