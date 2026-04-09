local M = {}

function M.setup()
  local ok, null_ls = pcall(require, "null-ls")
  if not ok then
    return
  end

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      pcall(require, "none-ls.diagnostics.eslint_d") and require("none-ls.diagnostics.eslint_d") or nil,
    },
  })

  vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
end

return M
