
local dap = require "dap"
local cpp = require "custom.configs.dap.languges.cpp"
local rust = require "custom.configs.dap.languges.rust"

dap.configurations.cpp = cpp
dap.configurations.rust = rust
