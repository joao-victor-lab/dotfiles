lvim.plugins = {

  "lunarvim/darkplus.nvim",
  "ThePrimeagen/vim-be-good",
  "opalmay/vim-smoothie",
  "windwp/nvim-ts-autotag",
  "kylechui/nvim-surround",
  "petertriho/nvim-scrollbar",
  "folke/zen-mode.nvim",
  "kevinhwang91/nvim-bqf",
  "ThePrimeagen/harpoon",
  "lvimuser/lsp-inlayhints.nvim",
  "Mofiqul/dracula.nvim",
  "NvChad/nvim-colorizer.lua",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "0x100101/lab.nvim",
    build = "cd js && npm ci",
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine' },
  {url = "https://github.com/editorconfig/editorconfig-vim"},

}
