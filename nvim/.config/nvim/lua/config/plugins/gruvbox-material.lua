local M = {}

function M.setup()
  -- original configuration for gruvbox-material
  vim.g.gruvbox_material_enable_italic = true
  vim.cmd.colorscheme("gruvbox-material")
  -- Keep transparent background like before
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
