local options = {
  lsp_fallback = true,

  formatters_by_ft = {

    lua = { "stylua" },

    -- javascript = { "biome" },
    -- javascriptreact = { "biome" },
    -- typescript = { "biome" },
    -- typescriptreact = { "biome" },
    --
    -- css = { "biome" },
    -- html = { "biome" },
    -- json = { "biome" },
    -- jsonc = { "biome" },

    -- sh = { "shfmt" },

    java = { "google-java-format" },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

require("conform").setup(options)
