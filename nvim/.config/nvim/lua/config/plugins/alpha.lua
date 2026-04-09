local M = {}

function M.setup()
  local ok_alpha, alpha = pcall(require, "alpha")
  if not ok_alpha then
    return
  end

  local ok_dashboard, dashboard = pcall(require, "config.alpha.startify-custom")
  if not ok_dashboard then
    -- nothing to configure
    return
  end

  -- prefer devicons if available
  if dashboard.file_icons then
    dashboard.file_icons.provider = "devicons"
  end

  pcall(function()
    alpha.setup(dashboard.opts)
  end)
end

return M
