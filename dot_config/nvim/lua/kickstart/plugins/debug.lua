-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'igorlfs/nvim-dap-view',

    -- Disassembly
    'https://codeberg.org/Jorenar/nvim-dap-disasm.git',

    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'theHamsta/nvim-dap-virtual-text',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F1>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F2>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F3>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F4>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },

    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>gb',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Run to cursor',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dap-view').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapview = require 'dap-view'

    require('nvim-dap-virtual-text').setup()

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = false,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {},
    }

    -- Dap View setup
    -- For more information, see |:help nvim-dap-view.txt|
    dapview.setup {
      winbar = {
        sections = {
          'console',
          'watches',
          'scopes',
          'exceptions',
          'breakpoints',
          'threads',
          'repl',
          'disassembly',
        },
      },

      auto_toggle = true,
    }

    -- Enable nvim-dap-disasm
    require('dap-disasm').setup {}

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#d20f39' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#df8e1d' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-dap',
      name = 'lldb',
    }

    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--quiet', '--interpreter=dap' },
    }

    dap.configurations.zig = {
      {
        name = 'Launch File',
        type = 'gdb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        args = {},
      },
      {
        name = 'Attach to process (GDB)',
        type = 'gdb',
        request = 'attach',
        processId = require('dap.utils').pick_process,
      },
    }
  end,
}
