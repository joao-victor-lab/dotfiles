---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<leader>fm"] = {
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      "Conform formating",
    },

    ["<leader>tt"] = {
      function()
        require("zen-mode").toggle()
      end,
      "toggle zen-mode",
    },

    ["<leader>tr"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle toggle transparency",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.treesj = {
  n = {
    ["<leader>ti"] = { "<CMD>TSJToggle<CR>", "Toggle Treesitter Join/Split" },
  },
}

M.debugger = {
  n = {
    ["<leader>dd"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "add/remove breakpoints",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "Launching or Run debug sessions",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_over()
      end,
      "Step out",
    },
    ["<F11>"] = {
      function()
        require("dap").repl.open()
      end,
      "open Repl",
    },
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "toggle debugger ui",
    },
    ["<leader>dt"] = { "<cmd> DapVirtualTextToggle <CR>", "toggle Vitual text" },
  },
}

M.harpoon = {
  n = {
    ["<leader>A"] = {
      function()
        require("harpoon"):list():append()
      end,
      "harpoon file",
    },
    ["<leader>a"] = {
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "harpoon quick menu",
    },
    ["<leader>1"] = {
      function()
        require("harpoon"):list():select(1)
      end,
      "harpoon to file 1",
    },
    ["<leader>2"] = {
      function()
        require("harpoon"):list():select(2)
      end,
      "harpoon to file 2",
    },
    ["<leader>3"] = {
      function()
        require("harpoon"):list():select(3)
      end,
      "harpoon to file 3",
    },
    ["<leader>4"] = {
      function()
        require("harpoon"):list():select(4)
      end,
      "harpoon to file 4",
    },
    ["<leader>5"] = {
      function()
        require("harpoon"):list():select(5)
      end,
      "harpoon to file 5",
    },
  },
}
return M
