return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files in git repo" })
      vim.keymap.set("n", "<leader>ps", function()
        builtin.live_grep()
      end, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>wd", function()
        print("Telescope is using cwd: " ..vim.fn.getcwd())
      end)
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          path_display = { "smart" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
