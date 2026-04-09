local M = {}

function M.setup()
  local ok, neoscroll = pcall(require, "neoscroll")
  if not ok then
    return
  end

  pcall(function()
    if neoscroll.setup then
      neoscroll.setup({})
    end
  end)
end

return M
