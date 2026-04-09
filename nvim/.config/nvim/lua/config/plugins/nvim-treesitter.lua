local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "json", "typescript", "tsx", "html", "css", "yaml" },
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
