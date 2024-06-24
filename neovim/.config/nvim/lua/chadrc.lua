-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local bn = require("banners")["random"]

M.ui = {
  theme = "tokyodark",
  theme_toggle = { "chadracula-evondev", "catppuccin" },
  transparency = true,
  lsp_semantic_tokens = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    NvDashAscii = { fg = "dark_purple", bg = "darker_black" },
  },

  cmp = {
    style = "atom_colored",
  },

  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
  },

  nvdash = {
    load_on_startup = true,

    header = bn,

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

M.base46 = {
  integrations = {
    "defaults",
    "todo",
    "navic",
    "git",
    "notify",
    "lsp",
    "semantic_tokens",
  },
}

return M
