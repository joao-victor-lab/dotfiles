---enables autocomplete for opts
---@module "auto-session"
---@type AutoSession.Config

return {
  -- ⚠️ This will only work if Telescope.nvim is installed
  -- The following are already the default values, no need to provide them if these are already the settings you want.
  bypass_save_filetypes = { "alpha", "dashboard" }, -- or whatever dashboard you use

  session_lens = {
    -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
    load_on_setup = true,
    previewer = false,
    -- mappings = {
    --   -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
    --   delete_session = { "i", "<C-D>" },
    --   alternate_session = { "i", "<C-S>" },
    -- },
    -- Can also set some Telescope picker options
    theme_conf = {
      border = true,
      -- layout_config = {
      --   width = 0.8, -- Can set width and height as percent of window
      --   height = 0.5,
      -- },
    },
  },
  post_cwd_changed_cmds = {
    function()
      require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
    end,
  },
}
