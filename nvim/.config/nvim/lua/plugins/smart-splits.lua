return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    -- NOTE: `wrap` is not supported on Kitty terminal
    at_edge = "wrap",
  },
  keys = {
    {
      "<C-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      mode = { "i", "n", "v" },
      desc = "Move to left window",
    },
    {
      "<C-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      mode = { "i", "n", "v" },
      desc = "Move to bottom window",
    },
    {
      "<C-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      mode = { "i", "n", "v" },
      desc = "Move to top window",
    },
    {
      "<C-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      mode = { "i", "n", "v" },
      desc = "Move to right window",
    },
    {
      "<C-\\>",
      function()
        require("smart-splits").move_cursor_previous()
      end,
      mode = { "i", "n", "v" },
      desc = "Move to previous window",
    },
    {
      "<M-h>",
      function()
        require("smart-splits").resize_left()
      end,
      mode = { "i", "n", "v" },
      desc = "Grow window left",
    },
    {
      "<M-j>",
      function()
        require("smart-splits").resize_down()
      end,
      mode = { "i", "n", "v" },
      desc = "Grow window down",
    },
    {
      "<M-k>",
      function()
        require("smart-splits").resize_up()
      end,
      mode = { "i", "n", "v" },
      desc = "Grow window up",
    },
    {
      "<M-l>",
      function()
        require("smart-splits").resize_right()
      end,
      mode = { "i", "n", "v" },
      desc = "Grow window right",
    },
    {
      "<leader><leader>h",
      function()
        require("smart-splits").swap_buf_left()
      end,
      mode = { "n" },
      desc = "Swap window left",
    },
    {
      "<leader><leader>j",
      function()
        require("smart-splits").swap_buf_down()
      end,
      mode = { "n" },
      desc = "Swap window down",
    },
    {
      "<leader><leader>k",
      function()
        require("smart-splits").swap_buf_up()
      end,
      mode = { "n" },
      desc = "Swap window up",
    },
    {
      "<leader><leader>l",
      function()
        require("smart-splits").swap_buf_right()
      end,
      mode = { "n" },
      desc = "Swap window right",
    },
  },
}
