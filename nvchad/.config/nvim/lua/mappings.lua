require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<A-t>", function()
  require("nvchad.themes").open { style = "bordered" }
end)

map("n", "<C-n>", function()
  require("yazi").yazi { open_for_directories = true }
end)

map("n", "<leader>eu", function()
  require("telescope").extensions.undo.undo()
end, { desc = "Undo files" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
