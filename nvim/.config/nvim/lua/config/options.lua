-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

-- Neovide config
if vim.g.neovide then
  -- Disable animations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
end

-- [[ Godot configuration ]]
-- Start nvim server if a project.godot file is detected.
local godot_projectfile = vim.fn.getcwd() .. "/project.godot"
local godot_socket_path = vim.fn.stdpath("run") .. "/godot.pipe"
if godot_projectfile and not vim.uv.fs_stat(godot_socket_path) then
  vim.fn.serverstart(godot_socket_path)
end
