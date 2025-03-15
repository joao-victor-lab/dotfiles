return {

  { "tpope/vim-sleuth", enabled = vim.g.lazy_pluggin_toogle.sleuth, lazy = false },

  {
    "neovim/nvim-lspconfig",
    enabled = vim.g.lazy_pluggin_toogle.lspconfig,
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      {
        "pmizio/typescript-tools.nvim",
        enabled = vim.g.lazy_pluggin_toogle.typescript_tools,
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
      },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = vim.fn.stdpath "data" .. "lazy/ui/nvchad_types", words = { "nvchad_types" } },
          },
        },
      },
      {
        "mfussenegger/nvim-jdtls",
        lazy = false,
        cond = function()
          return vim.fn.executable "java" == 1
        end,
        config = function()
          require "configs.jdtls"
        end,
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    enable = vim.g.lazy_pluggin_toogle.obsidian,
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/data/nots/BigBrain/",
        },
      },
      ui = { enable = false },
      templates = {},
    },
  },
  {
    "monkoose/neocodeium",
    enable = false,
    event = "VeryLazy",
    config = function()
      local neocodeium = require "neocodeium"
      local opts = {
        filetypes = {
          TelescopePrompt = false,
          ["dap-repl"] = false,
        },
      }
      neocodeium.setup { opts }
      vim.keymap.set("i", "<A-i>", neocodeium.accept)
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    cond = function()
      return vim.fn.executable "deno" == 1
    end,
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        javascript = { "biome" },
        ["_"] = { "trim_whitespace" },
      },

      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = vim.g.lazy_pluggin_toogle.notify,
    lazy = false,
    config = function()
      vim.notify = require "notify"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.g.lazy_pluggin_toogle.telescope_fzf_native,
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "matkrin/telescope-spell-errors.nvim" },
    },
    opts = function()
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "spell_errors")
    end,
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
  { "ellisonleao/glow.nvim", enabled = vim.g.lazy_pluggin_toogle.glow, config = true, cmd = "Glow" },
  {
    "folke/zen-mode.nvim",
    enabled = vim.g.lazy_pluggin_toogle.zen_mode,
    keys = {
      {
        "<leader>tz",
        function()
          require("zen-mode").toggle {
            window = {
              width = 0.72, -- width will be 85% of the editor width
            },
          }
        end,
        { desc = "toggle zen-mode" },
      },
    },
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = {},
      },
    },
    opts = {
      twilight = { enabled = true },
      todo = { enabled = true },

      -- this will change the font size on kitty when in zen mode
      -- to make this work, you need to set the following kitty options:
      -- - allow_remote_control socket-only
      -- - listen_on unix:/tmp/kitty
      kitty = {
        enabled = true,
        font = "+2.8", -- font size increment
      },
    },
  },
  -- Lua
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoQuickFix", "TodoLocList" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<C-n>",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      { -- Open in the current working directory
        "<A-n>",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },

      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        replace_in_directory = "<c-g>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
      -- { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    },

    opts = require "configs.auto-session",
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      local neoscroll = require "neoscroll"
      neoscroll.setup {
        -- Default easing function used in any animation where
        -- the `easing` argument has not been explicitly supplied
        easing = "quadratic",
      }
      local keymap = {
        -- Use the "sine" easing function
        ["<C-u>"] = function()
          neoscroll.ctrl_u { duration = 250, easing = "sine" }
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d { duration = 250, easing = "sine" }
        end,
        -- Use the "circular" easing function
        ["<C-b>"] = function()
          neoscroll.ctrl_b { duration = 450, easing = "circular" }
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f { duration = 450, easing = "circular" }
        end,
        -- When no value is passed the `easing` option supplied in `setup()` is used
        ["<C-y>"] = function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
        ["<C-e>"] = function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
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
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {},
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = vim.g.lazy_pluggin_toogle.obsidian,
    version = "*",
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "personal",
          path = "/data/robot/nots/BigBrain/",
        },
      },
      templates = {},
    },
  },
}
