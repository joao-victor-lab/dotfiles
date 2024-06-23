return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require "configs.lint"
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {

      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufRead" },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        opts = {
          mason = {
            "prettier",
            "stylua",
            "biome",
          },
          mason_lsp = {
            auto_install = true,
            "lua_ls",
            "ast_grep",
            "jdtls",
            "jsonls",
            "html",
            "cssls",
            "emmet_ls",
            "bashls",
          },
        },
        config = function(_, opts)
          local setup = require("configs.lspconfig").setup
          setup(_, opts)
        end,
      },

      {
        "williamboman/mason.nvim",
        lazy = false,
      },

      {
        "williamboman/mason-lspconfig.nvim",
      },

      { "mfussenegger/nvim-jdtls", ft = "java" },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library paths can be absolute
        "~/.config/nvim/",
        -- Or relative, which means they will be resolved from the plugin dir.
        "lazy.nvim",
        "luvit-meta/library",
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- always load the LazyVim library
        "LazyVim",
        -- Only load the lazyvim library when the `LazyVim` global is found
        { path = "LazyVim", words = { "LazyVim" } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
      },
      -- always enable unless `vim.g.lazydev_enabled = false`
      -- This is the default
      enabled = function(root_dir)
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    {
      "utilyre/barbecue.nvim",
      event = "LspAttach",
      dependencies = {
        "SmiteshP/nvim-navic",
      },
      opts = {},
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope" },
    opts = {},
  },

  {
    "rcarriga/nvim-notify",
    init = function()
      vim.notify = require "notify"
    end,
    config = function()
      require("telescope").load_extension "notify"
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  {
    {
      "okuuva/auto-save.nvim",
      event = { "InsertLeave", "TextChanged" },
      opts = {
        execution_message = {
          enabled = false,
        },
        callbacks = {
          before_saving = function()
            -- save global autoformat status
            vim.g.OLD_AUTOFORMAT = vim.g.autoformat_enabled
            vim.g.autoformat_enabled = false
            vim.g.OLD_AUTOFORMAT_BUFFERS = {}
            -- disable all manually enabled buffers
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if vim.b[bufnr].autoformat_enabled then
                table.insert(vim.g.OLD_BUFFER_AUTOFORMATS, bufnr)
                vim.b[bufnr].autoformat_enabled = false
              end
            end
          end,
          after_saving = function()
            -- restore global autoformat status
            vim.g.autoformat_enabled = vim.g.OLD_AUTOFORMAT
            -- reenable all manually enabled buffers
            for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
              vim.b[bufnr].autoformat_enabled = true
            end
          end,
        },
      },
    },
  },

  {
    {
      "kevinhwang91/nvim-ufo",
      event = "VimEnter",
      init = function()
        vim.o.foldcolumn = "auto"
        vim.o.foldlevel = 99 -- Using ufo provider need a large value
        vim.o.foldlevelstart = 99
        vim.o.foldnestmax = 0
        vim.o.foldenable = true
        vim.o.foldmethod = "indent"

        vim.opt.fillchars = {
          fold = " ",
          foldopen = "",
          foldsep = " ",
          foldclose = "",
          stl = " ",
          eob = " ",
        }
      end,
      dependencies = {
        { "kevinhwang91/promise-async" },

        {
          "luukvbaal/statuscol.nvim",
          opts = function()
            local builtin = require "statuscol.builtin"
            return {
              relculright = true,
              bt_ignore = { "nofile", "prompt", "terminal", "packer" },
              ft_ignore = {
                "NvimTree",
                "dashboard",
                "nvcheatsheet",
                "dapui_watches",
                "dap-repl",
                "dapui_console",
                "dapui_stacks",
                "dapui_breakpoints",
                "dapui_scopes",
                "help",
                "vim",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "noice",
                "lazy",
                "toggleterm",
              },

              segments = {
                -- Segment: Add padding
                {
                  text = { " " },
                },
                -- Segment: Fold Column
                {
                  text = { builtin.foldfunc },
                  click = "v:lua.ScFa",
                  maxwidth = 1,
                  colwidth = 1,
                  auto = false,
                },
                -- Segment: Add padding
                {
                  text = { " " },
                },
                -- Segment : Show signs with one character width
                {
                  sign = {
                    name = { ".*" },
                    maxwidth = 1,
                    colwidth = 1,
                  },
                  auto = true,
                  click = "v:lua.ScSa",
                },
                -- Segment: Show line number
                {
                  text = { " ", " ", builtin.lnumfunc, " " },
                  click = "v:lua.ScLa",
                  condition = { true, builtin.not_empty },
                },
                -- Segment: GitSigns exclusive
                {
                  sign = {
                    namespace = { "gitsign.*" },
                    maxwidth = 1,
                    colwidth = 1,
                    auto = false,
                  },
                  click = "v:lua.ScSa",
                },
                -- Segment: Add padding
                {
                  text = { " " },
                  hl = "Normal",
                  condition = { true, builtin.not_empty },
                },
              },
            }
          end,
        },
      },
      opts = {
        ft_ignore = {
          "NvimTree",
          "dashboard",
          "nvcheatsheet",
          "dapui_watches",
          "dap-repl",
          "dapui_console",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "help",
          "vim",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "noice",
          "lazy",
          "toggleterm",
        },
        close_fold_kinds_for_ft = { default = { "imports" } },
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      },
    },
  },

  {
    {
      "code-biscuits/nvim-biscuits",
      event = "BufReadPost",
      opts = {
        show_on_start = false,
        cursor_line_only = true,
        default_config = {
          min_distance = 10,
          max_length = 50,
          prefix_string = " 󰆘 ",
          prefix_highlight = "Comment",
          enable_linehl = true,
        },
      },
    },
  },
  {
    {
      "karb94/neoscroll.nvim",
      keys = { "<C-d>", "<C-u>" },
      opts = {
        mappings = {
          "<C-u>",
          "<C-d>",
        },
      },
    },
  },
}
