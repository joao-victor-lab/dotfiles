require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local Gmap = vim.api.nvim_set_keymap

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "v" }, "<A-j>", ":m .+1<CR>==")
map({ "n", "v" }, "<A-k>", ":m .-2<CR>==")

Gmap("n", "<leader>cs", ":ASToggle<CR>", {})

map("n", "zR", require("ufo").openAllFolds, {})
map("n", "zM", require("ufo").closeAllFolds, {})
