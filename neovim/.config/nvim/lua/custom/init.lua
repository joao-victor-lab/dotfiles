local M = {}

--vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- vim.opt.relativenumber = true

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("jdtls launch", { clear = true })
autocmd("Filetype", {
  group = "jdtls launch",
  pattern = { "java" },
  callback = function()
    local launch_jdtls = require("custom.configs.jdtls.launch")
    launch_jdtls.setup()
  end,
})


-- augroup("java Indent", { clear = true })
-- autocmd("Filetype", {
--   group = "java Indent",
--   pattern = { "java" },
--   command = "setlocal shiftwidth=4 tabstop=4",
-- })

return M
