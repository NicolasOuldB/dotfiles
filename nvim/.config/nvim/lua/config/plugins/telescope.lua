local M = {}

function M.setup()
  -- Defensive requires so missing plugin doesn't break startup
  local ok_telescope, telescope = pcall(require, "telescope")
  if not ok_telescope then
    return
  end

  local ok_themes, themes = pcall(require, "telescope.themes")
  local ok_builtin, builtin = pcall(require, "telescope.builtin")

  local vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  }

  local defaults = {
    vimgrep_arguments = vimgrep_arguments,
    path_display = { "smart" },
  }

  local extensions = {}
  if ok_themes and themes and themes.get_dropdown then
    -- ui-select extension expects a table config; pass dropdown theme if available
    extensions["ui-select"] = themes.get_dropdown({})
  end

  -- Apply setup and safely load ui-select extension
  pcall(function()
    telescope.setup({ defaults = defaults, extensions = extensions })
    if telescope.load_extension then
      pcall(telescope.load_extension, "ui-select")
    end
  end)

  -- Keymaps using builtin pickers
  if ok_builtin and builtin then
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files in git repo" })
    vim.keymap.set("n", "<leader>ps", function()
      builtin.live_grep()
    end, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>wd", function()
      print("Telescope is using cwd: " .. vim.fn.getcwd())
    end)
  end
end

return M
