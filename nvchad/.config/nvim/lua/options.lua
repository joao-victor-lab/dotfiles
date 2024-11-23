require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt
o.cursorlineopt = "both" -- to enable cursorline!
opt.termguicolors = true
opt.spelllang = "pt_br"
opt.undofile = true

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
