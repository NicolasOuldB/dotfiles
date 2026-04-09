local M = {}

function M.setup()
  local ok, smear = pcall(require, "smear-cursor")
  if not ok or not smear then
    -- plugin not installed or failed; do nothing
    return
  end

  -- apply options if setup is available
  pcall(function()
    if smear.setup then
      smear.setup({
        cursor_color = "#a89984",
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        damping = 0.67,
        matrix_pixel_threshold = 0.5,
      })
    end
  end)
end

return M
