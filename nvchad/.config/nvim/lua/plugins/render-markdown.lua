return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {
    enabled = true,
    file_types = { "markdown", "quatro" },
    render_modes = { "n", "c" },
    injections = {
      gitcommit = {
        enabled = true,
        query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
      },
    },
  },
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
}
