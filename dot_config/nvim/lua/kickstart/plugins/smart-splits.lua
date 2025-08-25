return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {},
  keys = {
    -- Move between splits in nvim and smart-splits supported terminals.
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Go to Left Window',
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Go to Lower Window',
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Go to Upper Window',
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Go to Right Window',
    },
    -- Resize splits.
    {
      '<A-h>',
      function()
        require('smart-splits').resize_left()
      end,
    },
    {
      '<A-j>',
      function()
        require('smart-splits').resize_down()
      end,
    },
    {
      '<A-k>',
      function()
        require('smart-splits').resize_up()
      end,
    },
    {
      '<A-l>',
      function()
        require('smart-splits').resize_right()
      end,
    },
  },
}
