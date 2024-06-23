require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = 'both' -- to enable cursorline!

-- vim.g.lsp_zero_extend_lspconfig = 0
--
vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/hypr/.*%.hl"] = "hyprlang"
  },
})
