return {
  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "configs.lspconfig"
  --   end,
  -- },

  { "nvim-telescope/telescope-fzf-native.nvim", enabled = true, build = "make" },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require "notify"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = { extensions_list = { "themes", "terms", "fzf", "notify" } },
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
