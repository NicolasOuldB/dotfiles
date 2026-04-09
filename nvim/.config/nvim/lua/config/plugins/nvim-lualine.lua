local M = {}

function M.setup()
  local custom_gruvbox = require("lualine.themes.gruvbox-material")

  -- Custom colours
  -- Ensure theme table shape exists (some theme versions may omit sub-tables)
  local function ensure(tbl, key)
    if not tbl[key] then tbl[key] = {} end
    return tbl[key]
  end

  ensure(custom_gruvbox, "normal")
  ensure(custom_gruvbox.normal, "a")
  ensure(custom_gruvbox.normal, "b")
  ensure(custom_gruvbox, "insert")
  ensure(custom_gruvbox.insert, "a")
  ensure(custom_gruvbox.insert, "b")
  ensure(custom_gruvbox, "visual")
  ensure(custom_gruvbox.visual, "a")
  ensure(custom_gruvbox.visual, "b")
  ensure(custom_gruvbox, "replace")
  ensure(custom_gruvbox.replace, "a")
  ensure(custom_gruvbox.replace, "b")
  ensure(custom_gruvbox, "command")
  ensure(custom_gruvbox.command, "a")
  ensure(custom_gruvbox.command, "b")

  custom_gruvbox.normal.a.bg = "#9e8e72"
  custom_gruvbox.normal.b.bg = "#4a4338"
  custom_gruvbox.insert.a.bg = "#6f8352"
  custom_gruvbox.insert.b.bg = "#333e34"
  custom_gruvbox.visual.a.bg = "#db4740"
  custom_gruvbox.visual.b.bg = "#3c1f1e"
  custom_gruvbox.replace.a.bg = "#b47109"
  custom_gruvbox.replace.b.bg = "#614617"
  custom_gruvbox.command.a.bg = "#45707a"
  custom_gruvbox.command.b.bg = "#0d3138"

  require('lualine').setup({
    options = {
      theme = custom_gruvbox,
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = " ", right = "" }, icon = "" },
      },
      lualine_b = {
        {"filename", separator = { left = "", right = "" }}
      },
      lualine_c = {
        {
          "branch",
          icon = "",
        },
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
          colored = true,
        },
      },
      lualine_x = {
        {
          "diagnostics",
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          update_in_insert = true,
        },
      },
      lualine_z = {
        { "location", separator = { left = "", right = " " }, icon = "" },
      },
    },
  })
end

return M
