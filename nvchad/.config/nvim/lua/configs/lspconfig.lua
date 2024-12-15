-- for fancy icons 
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()
local noop = function() end
local nvlsp = require "nvchad.configs.lspconfig"

-- require("nvchad.configs.lspconfig").defaults()

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --

  ts_ls = {},

  lua_ls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua", -- Used to format Lua code
  "biome",
})

require("mason-tool-installer").setup { ensure_installed = ensure_installed }
require("mason-lspconfig").setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}

      -- server.init = nvlsp.on_init or {} -- for now enable semantic tokens
      server.on_attach = nvlsp.on_attach or {}

      require("lspconfig")[server_name].setup(server)
    end,
    jdtls = noop,
  },
}
-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*/hypr/**" },
  callback = function(event)
    vim.lsp.start {
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    }
  end,
})
