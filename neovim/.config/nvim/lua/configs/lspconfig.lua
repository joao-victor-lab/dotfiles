local F = {}
--TODO: set up dap

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰫤",
      [vim.diagnostic.severity.INFO] = "󱈸",
    },
  },
  virtual_text = true,
}

vim.api.nvim_create_user_command("ToggleDiagnostic", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { nargs = 0 })

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("hyprls_atach", { clear = true }),
  pattern = { "*/hypr/*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start {
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    }
  end,
})

F.setup = function(_, opts)
  local on_attach = require("nvchad.configs.lspconfig").on_attach
  local lsp_zero = require "lsp-zero"

  -- require("neodev").setup {
  --   require "configs.neodev",
  -- }

  lsp_zero.on_attach(function(client, bufnr)
    on_attach(client, bufnr)
  end)

  require("mason").setup {
    ensure_installed = opts.mason,
  }

  require("mason-lspconfig").setup {

    ensure_installed = opts.mason_lsp,
    automatic_installation = opts.mason_lsp.auto_install,

    handlers = {
      function(name)
        local lsp = require("lspconfig")[name]
        if lsp.manager then
          -- if lsp.manager is defined it means the
          -- language server was configured some place else
          return
        end

        if lsp[name] ~= "lua_ls" then
          local lua_opts = lsp_zero.nvim_lua_ls(require "configs.luals_props")
          require("lspconfig").lua_ls.setup(lua_opts)
        end

        if lsp[name] ~= "jdtls" then
          return
        end

        lsp_zero.default_setup(name)
      end,
    },
  }
  lsp_zero.extend_lspconfig()
end

return F
