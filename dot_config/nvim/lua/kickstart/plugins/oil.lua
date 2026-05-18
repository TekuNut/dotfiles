---@module "lazy"
---@type LazySpec
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'echasnovski/mini.icons' },
  cmd = 'Oil',
  lazy = false,
  keys = {
    { '<leader>fo', '<cmd>Oil<cr>', desc = 'Oil: Open parent directory' },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    columns = { 'icon' },
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        -- Hide godot files that are only useful for the editor or are operational files.
        local godot_patterns = {
          '%.uid[/]?$', -- .uid files
          '%.import[/]?$', -- .import files
          '^%.godot[/]?$', -- .godot directory
          '^%.mono[/]?$', -- .mono directory
          'godot.*%.tmp$', -- godot temp files
        }

        for _, pat in ipairs(godot_patterns) do
          if name:match(pat) then
            return true
          end
        end

        return name == '..' or name == '.git'
      end,
    },
    win_options = {
      wrap = true,
      cursorcolumn = false,
    },
    watch_for_changes = true,
    use_default_keymaps = true,
  },
}
