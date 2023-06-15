local pid = vim.fn.getpid()

local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
    { "folke/neodev.nvim", config = true },
  },
  config = function()
    require("core.plugins.lsp.lsp")
  end,
}

return M
