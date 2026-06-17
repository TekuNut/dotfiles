return {
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    lazy = false, -- plugin is self-lazy-loading
    cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerRun",
        "OverseerTaskAction",
    },
    keys = {
      { "<LocalLeader>ow", "<cmd>OverseerToggle!<cr>",    desc = "Task list" },
      { "<LocalLeader>oo", "<cmd>OverseerRun<cr>",        desc = "Run task" },
      { "<LocalLeader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    }
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<LocalLeader>o", group = "overseer" },
      },
    },
  },
}
