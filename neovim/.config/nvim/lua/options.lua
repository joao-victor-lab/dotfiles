require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt = "both" -- to enable cursorline!
o.foldcolumn = "1"
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

-- vim.g.lsp_zero_extend_lspconfig = 0
--
vim.filetype.add {
  extension = {
    zsh = "sh",
    sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
  },
  pattern = {
    [".*/hypr/*.conf"] = "hyprlang",
    ["*/hypr/*.hl"] = "hyprlang",
  },
  filename = {
    [".zshrc"] = "sh",
    [".zprofile"] = "sh",
    [".zshenv"] = "sh",
  },
}

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰫤",
      [vim.diagnostic.severity.INFO] = "󱈸",
    },
  },
}
