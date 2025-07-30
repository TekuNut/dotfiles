return {
  'numToStr/Navigator.nvim',
  lazy = false,
  opts = {},
  keys = {
    {
      '<C-h>',
      '<cmd>NavigatorLeft<cr>',
      desc = 'Navigator: Move to left buffer/pane',
    },
    {
      '<C-l>',
      '<cmd>NavigatorRight<cr>',
      desc = 'Navigator: Move to right buffer/pane',
    },
    {
      '<C-j>',
      '<cmd>NavigatorDown<cr>',
      desc = 'Navigator: Move to bottom buffer/pane',
    },
    {
      '<C-k>',
      '<cmd>NavigatorUp<cr>',
      desc = 'Navigator: Move to top buffer/pane',
    },
  },
}
