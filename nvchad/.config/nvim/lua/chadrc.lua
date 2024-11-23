-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadtain",
  transparency = true,
  integrations = {
    "defaults",
    "notify",
    "markview",
    "cmp",
    "git",
    "semantic_tokens",
    "trouble",
    "todo",
    "bufferline",
    "statusline",
    "treesitter",
    "whichkey",
    "diffview",
  },
}

M.ui = {
  cmp = {
    style = "atom",
    format_colors = {
      tailwind = true,
    },
  },
}

return M
