local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  { "NvChad/nvcommunity" },
  { import = "nvcommunity.editor.beacon" },
  { import = "nvcommunity.editor.telescope-undo" },
  { import = "nvcommunity.editor.rainbowdelimiters" },

  { import = "nvcommunity.lsp.barbecue" },
  { import = "nvcommunity.lsp.prettyhover" },
  { import = "nvcommunity.lsp.lspui" },

  { import = "nvcommunity.motion.neoscroll" },
  { import = "nvcommunity.motion.hop" },

  { import = "nvcommunity.git.lazygit" },

  --bookmarks 🔖
  { import = "nvcommunity.motion.bookmarks" },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
  },

  { import = "nvcommunity.tools.telescope-fzf-native" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
      require "custom.configs.mason-lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  { import = "nvcommunity.lsp.mason-lspconfig" },
  {
    "mason-lspconfig",
    config = function()
      require "custom.configs.mason-lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.linters"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  --fancy notify 💭
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require "notify"
    end,
  },

  --dap ⚙️
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
    opts = {},
    config = function()
      require "custom.configs.dap.dap_configs"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require "custom.configs.dap.ui"
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    opts = overrides.dap_virtualText,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  { "leoluz/nvim-dap-go" },

  {
    {
      "Wansmer/treesj",
      keys = { { "<leader>m", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" } },
      cmd = { "TSJToggle" },
      opts = { use_default_keymaps = false },
    },
  },

  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require "custom.configs.zen_mode"
    end,
  },

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = overrides.auto_save,
  },
}

return plugins
