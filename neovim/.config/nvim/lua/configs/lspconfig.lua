local F = {}
--TODO: set up dap

F.setup = function(_, opts)
  local on_attach = require("nvchad.configs.lspconfig").on_attach
  local lsp_zero = require "lsp-zero"

  require("ufo").setup()

  -- lsp_zero.on_attach(function(client, bufnr) end)

  lsp_zero.set_server_config {
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
  }

  require("mason").setup {
    ensure_installed = {
      "prettier",
      "stylua",
      "biome",
    },
  }

  require("mason-lspconfig").setup {

    automatic_installation = true,
    ensure_installed = {
      "lua_ls",
      -- "ast_grep",
      "jdtls",
      "jsonls",
      "html",
      "cssls",
      "emmet_ls",
      "bashls",
    },
    handlers = {
      lsp_zero.default_setup,
    },
  }
  lsp_zero.extend_lspconfig()
end

return F
