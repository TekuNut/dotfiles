return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    dim_inactive = {
      enabled = true, -- dims the background color of inactive windows
      shade = "dark",
      percentage = 0.30,
    },
    integrations = {
      harpoon = true,
      mason = true,
      neotest = true,
      noice = true,
      cmp = true,
      dap = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      treesitter = true,
      snacks = true,
      lsp_trouble = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
