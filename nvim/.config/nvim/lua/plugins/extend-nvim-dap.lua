return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")
    if not dap.adapters.godot then
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }
    end

    if not dap.configurations.gdscript then
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "GDScript: Launch Project",
          project = "${workspaceFolder}",
        },
      }
    end
  end,
}
