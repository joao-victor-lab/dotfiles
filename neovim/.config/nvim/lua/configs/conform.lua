local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "biome", "prettier" } },
    -- css = { "prettier" },
    -- html = { "prettier" },
    zsh = { "shfmt" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    java = { "google-java-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 600,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
