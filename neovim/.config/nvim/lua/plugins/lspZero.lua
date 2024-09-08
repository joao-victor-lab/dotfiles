return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = true,
    config = false,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      local nvlsp = require "nvchad.configs.lspconfig"

      local lsp_zero = require "lsp-zero"

      require("mason-lspconfig").setup {
        ensure_installed = {},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            local lsp = require("lspconfig")[server_name]
            if lsp.manager then
              return
            end

            lsp.setup {
              on_attach = nvlsp.on_attach,
              on_init = nvlsp.on_init,
              capabilities = nvlsp.capabilities,
            }
          end,
          jdtls = lsp_zero.noop,
        },
      }
    end,
  },
}
