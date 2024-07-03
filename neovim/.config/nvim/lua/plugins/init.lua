return {

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "*",
    lazy = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufRead" },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        opts = {},
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
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  dependencies = {
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
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
