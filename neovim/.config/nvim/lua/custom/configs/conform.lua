-- luacheck: globals vim
local slow_format_filetypes = {}
local options = {

  lsp_fallback = true,

  formatters_by_ft = {

    lua = { "stylua" },

    -- front stuff
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },

    sh = function(bufnr)
      if require("conform").get_formatter_info("beautysh", bufnr).available then
        return { "beautysh" }
      else
        return { "shfmt" }
      end
    end,

    bash = function(bufnr)
      if require("conform").get_formatter_info("beautysh", bufnr).available then
        return { "beautysh" }
      else
        return { "shfmt" }
      end
    end,

    zsh = function(bufnr)
      if require("conform").get_formatter_info("beautysh", bufnr).available then
        return { "beautysh" }
      else
        return { "shfmt" }
      end
    end,

    java = { "google-java-format" },
    xml = { "xmlformatter" },

    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,

    ["_"] = { "trim_whitespace" },
  },

  -- For custom formatters
  formatters = {},

  format_on_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = {}
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match "/node_modules/" then
      return
    end
    if slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end

    local function on_format(err)
      if err and err:match "timeout$" then
        slow_format_filetypes[vim.bo[bufnr].filetype] = true
      end
    end

    return { timeout_ms = 500, lsp_fallback = true }, on_format
  end,

  format_after_save = function(bufnr)
    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- ...additional logic...
    return { lsp_fallback = true }
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
