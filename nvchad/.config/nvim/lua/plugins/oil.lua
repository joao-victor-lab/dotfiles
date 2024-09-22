return {
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    event = "VeryLazy",
    cmd = "Oil",
    keys = {
      {
        "<C-n>",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
  },
}
