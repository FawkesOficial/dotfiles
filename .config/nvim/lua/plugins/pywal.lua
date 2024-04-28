return {
    "AlphaTechnolog/pywal.nvim",
    lazt = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all other plugins.
    init = function()
      vim.cmd.colorscheme "pywal"
    end,
  }
