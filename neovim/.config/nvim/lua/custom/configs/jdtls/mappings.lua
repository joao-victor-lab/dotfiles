-- NOTE: Java specific keymaps with which key
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

require("core.mappings").jdtls_mappings = {
  plugin = true,
  n = {
    ["<leader>Jo"] = {
      function()
        require("jdtls").organize_imports()
      end,
      "Organize Imports",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Jv"] = {
      function()
        require("jdtls").extract_variable()
      end,
      "Extract Variable",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Jc"] = {
      function()
        require("jdtls").extract_constant()
      end,
      "Extract Constant",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Jt"] = {
      function()
        require("jdtls").test_nearest_method()
      end,
      "Test Method",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>JT"] = {
      function()
        require("jdtls").test_nearest_method()
      end,
      "Test Method",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Ju"] = {
      "<Cmd>JdtUpdateConfig<CR>",
      "Update Config",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
  },
  v = {
    ["<leader>Jv"] = {
      function()
        require("jdtls").extract_variable(true)
      end,
      "Update Config",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Jc"] = {
      function()
        require("jdtls").extract_constant(true)
      end,
      "Update Config",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
    ["<leader>Jm"] = {
      function()
        require("jdtls").extract_method(true)
      end,
      "Update Config",
      opts = { silent = true, noremap = true, buffer = nil, nowait = true },
    },
  },
}

require("core.utils").load_mappings "jdtls_mappings"
