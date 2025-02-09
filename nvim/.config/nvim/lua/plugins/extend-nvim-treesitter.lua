return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Install Godot related parsers
    table.insert(opts.ensure_installed, "gdscript")
    table.insert(opts.ensure_installed, "godot_resource")
    table.insert(opts.ensure_installed, "gdshader")
  end,
}
