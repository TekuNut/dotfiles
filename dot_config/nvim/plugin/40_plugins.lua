-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
	-- Define hook to update tree-sitter parsers after plugin is updated
	local ts_update = function()
		vim.cmd("TSUpdate")
	end
	Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

	add({
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	})

	-- Define languages which will have parsers installed and auto enabled
	-- After changing this, restart Neovim once to install necessary parsers. Wait
	-- for the installation to finish before opening a file for added language(s).
	local languages = {
		-- These are already pre-installed with Neovim. Used as an example.
		"lua",
		"vimdoc",
		"markdown",
		"c",
		"cpp",
		"json",
		"python",
		"yaml",
		-- Add here more languages with which you want to use tree-sitter
		-- To see available languages:
		-- - Execute `:=require('nvim-treesitter').get_available()`
		-- - Visit 'SUPPORTED_LANGUAGES.md' file at
		--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
	}
	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, languages)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end

	-- Enable tree-sitter after opening a file for a target language
	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local ts_start = function(ev)
		vim.treesitter.start(ev.buf)
	end
	Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
end)

-- Neoconf ====================================================================
now_if_args(function()
	add({})
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.lsp` to see potential issues.
now_if_args(function()
	add({ "https://github.com/neovim/nvim-lspconfig" })

	-- Use `:h vim.lsp.enable()` to automatically enable language server based on
	-- the rules provided by 'nvim-lspconfig'.
	-- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
	-- Uncomment and tweak the following `vim.lsp.enable()` call to enable servers.
	vim.lsp.enable({
		"clangd",
		"lua_ls",
	})
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
--
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
	add({ "https://github.com/stevearc/conform.nvim" })

	-- See also:
	-- - `:h Conform`
	-- - `:h conform-options`
	-- - `:h conform-formatters`
	require("conform").setup({
		default_format_opts = {
			-- Allow formatting from LSP server if no dedicated formatter is available
			lsp_format = "fallback",
		},
		-- Map of filetype to formatters
		-- Make sure that necessary CLI tool is available
		formatters_by_ft = { lua = { "stylua" } },
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
	add({ "https://github.com/rafamadriz/friendly-snippets" })
end)

-- Mason =========================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
now_if_args(function()
	add({ "https://github.com/mason-org/mason.nvim" })
	require("mason").setup({
		firewall = {
			enabled = true,
		},
	})
end)

-- DAP =========================================================================
-- TODO: Add description.
later(function()
	add({
		"https://github.com/mfussenegger/nvim-dap",
		"https://github.com/theHamsta/nvim-dap-virtual-text",
		"https://github.com/igorlfs/nvim-dap-view",
		"https://codeberg.org/Jorenar/nvim-dap-disasm.git",
	})

	local dap = require("dap")
	local dapview = require("dap-view")

	require("nvim-dap-virtual-text").setup()

	-- Dap View setup
	-- For more information, see |:help nvim-dap-view.txt|
	dapview.setup({
		winbar = {
			sections = {
				"watches",
				"scopes",
				"exceptions",
				"breakpoints",
				"threads",
				"repl",
				"disassembly",
			},
			controls = {
				enabled = true,
			},
		},
    windows = {
      size = 0.5,
      position = function(prev)
            local wins = vim.api.nvim_tabpage_list_wins(0)

            -- Restores previous position if terminal is visible
            if
                vim.iter(wins):find(function(win)
                    return vim.w[win].dapview_win_term
                end)
            then
                return prev
            end

            return vim.tbl_count(vim.iter(wins)
                :filter(function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    local valid_buftype =
                        vim.tbl_contains({ "", "help", "prompt", "quickfix", "terminal" }, vim.bo[buf].buftype)
                    local dapview_win = vim.w[win].dapview_win or vim.w[win].dapview_win_term
                    return valid_buftype and not dapview_win
                end)
                :totable()) > 1 and "below" or "right"
      end,
      size = function(pos)
          return pos == "below" and 0.25 or 0.5
      end,
      terminal = {
          -- `pos` is the position for the regular window
          position = function(pos)
              return pos == "below" and "right" or "below"
          end,
          size = 0.5,
      },
    },

		auto_toggle = true,
	})

	-- Change breakpoint icons
	vim.api.nvim_set_hl(0, "DapBreak", { fg = "#d20f39" })
	vim.api.nvim_set_hl(0, "DapStop", { fg = "#df8e1d" })
	local breakpoint_icons = vim.g.have_nerd_font
			and {
				Breakpoint = "",
				BreakpointCondition = "",
				BreakpointRejected = "",
				LogPoint = "",
				Stopped = "",
			}
		or {
			Breakpoint = "●",
			BreakpointCondition = "⊜",
			BreakpointRejected = "⊘",
			LogPoint = "◆",
			Stopped = "⭔",
		}
	for type, icon in pairs(breakpoint_icons) do
		local tp = "Dap" .. type
		local hl = (type == "Stopped") and "DapStop" or "DapBreak"
		vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
	end

	-- Enable nvim-dap-disasm
	require("dap-disasm").setup({})

	dap.adapters.lldb = {
		type = "executable",
		command = "lldb-dap",
		name = "lldb",
	}

	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "--quiet", "--interpreter=dap" },
	}

	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", "<S-F5>", function()
		require("dap").close()
    require("dap-view").close()
	end)
	vim.keymap.set("n", "<F10>", function()
		require("dap").step_over()
	end)
	vim.keymap.set("n", "<F11>", function()
		require("dap").step_into()
	end)
	vim.keymap.set("n", "<F12>", function()
		require("dap").step_out()
	end)
	vim.keymap.set("n", "<Leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Toggle breakpoint" })
	vim.keymap.set("n", "<Leader>dB", function()
		local condition = vim.fn.input("Breakpoint condition (optional): ")
		local hit_condition = vim.fn.input("Hit count (optional): ")

		-- Convert empty strings to nil
		condition = condition ~= "" and condition or nil
		hit_condition = hit_condition ~= "" and hit_condition or nil

		require("dap").toggle_breakpoint(condition, hit_condition)
	end, { desc = "Toggle advanced breakpoint" })
	vim.keymap.set("n", "<Leader>dg", function()
		require("dap").run_to_cursor()
	end, { desc = "Run to cursor" })
	vim.keymap.set("n", "<Leader>dl", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "Set log breakpoint" })
	vim.keymap.set("n", "<Leader>dd", function()
		require("dap-view").jump_to_view("disassembly")
	end, { desc = "Disassembly" })
	vim.keymap.set("n", "<Leader>dw", function()
		require("dap-view").jump_to_view("watches")
	end, { desc = "Stack frames" })
	vim.keymap.set("n", "<Leader>dr", function()
		require("dap-view").jump_to_view("repl")
	end, { desc = "Open REPL" })
	vim.keymap.set("n", "<Leader>df", function()
		require("dap-view").jump_to_view("threads")
	end, { desc = "Stack frames" })
	vim.keymap.set("n", "<Leader>dt", function()
		require("dap-view").jump_to_view("threads")
	end, { desc = "Threads" })

	vim.keymap.set("n", "<Leader>ds", function()
		require("dap-view").jump_to_view("scopes")
	end, { desc = "Scopes" })
end)

-- Overseer
-- TODO: Description
later(function()
	add({
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/civitasv/cmake-tools.nvim",
	})

	require("cmake-tools").setup({
		cmake_dap_configuration = {
			name = "cpp",
			type = "lldb",
			request = "launch",
			stopOnEntry = false,
		},
	})
end)

-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'miniwinter'
-- enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
-- Config.now(function()
--  -- Install only those that you need
later(function()
	add({
		{ src = "https://github.com/catppuccin/nvim", name = "catppuccin-nvim" },
	})

	require("catppuccin").setup({
		mason = true,
		dap = true,
		mini = {
			enabled = true,
			identscope_color = "",
		},
		treesitter = true,
	})

	vim.cmd.colorscheme("catppuccin")
end)
