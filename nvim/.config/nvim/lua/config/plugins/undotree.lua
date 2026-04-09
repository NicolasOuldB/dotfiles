local M = {}

function M.setup()
  local ok, undotree = pcall(require, "undotree")
  if not ok then
    return
  end

  pcall(function()
    undotree.setup({ position = "right" })
  end)

  -- Keymap to toggle undotree
  vim.keymap.set("n", "<leader>u", function()
    if undotree.toggle then
      undotree.toggle()
    end
  end, { noremap = true, silent = true })
end

return M
