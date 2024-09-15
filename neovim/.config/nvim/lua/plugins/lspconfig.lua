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
          lua_ls = lsp_zero.noop,
          jdtls = lsp_zero.noop,
        },
      }
      -- Hyprlang LSP
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.hl", "hypr*.conf", "*/hypr/**" },
        callback = function(event)
          vim.lsp.start {
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
          }
        end,
      })
    end,
  },
}
