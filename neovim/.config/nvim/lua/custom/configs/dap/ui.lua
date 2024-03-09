local dap, dapui = require "dap", require "dapui"

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DapBreakpointSymbol",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapStopped", {
  text = "󰨰",
  texthl = "DapStoppedSymbol",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})

require("dapui").setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
