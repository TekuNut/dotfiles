return {
  'Mathijs-Bakker/godotdev.nvim',
  dependencies = { 'nvim-dap', 'nvim-dap-ui', 'nvim-treesitter' },
  opts = {
    csharp = true,
  },
  keys = {
    { '<leader>Gk', '<cmd>GodotDocs<cr>', desc = 'Godot Docs' },
  },
}
