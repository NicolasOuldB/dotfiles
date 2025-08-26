return
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    keys = {
      { "<leader>tr", "<cmd>Neotest run<cr>" },
      { "<leader>ti", "<cmd>Neotest output<cr>" },
      { "<leader>ts", "<cmd>Neotest summary<cr>" },
      { "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>" },
    },
    config = function ()

      local jutro_adapter = require("neotest.jutro")

      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm run test --",
            jestConfigFile = vim.fn.getcwd() .. "/jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          -- jutro_adapter,
        },
      })
    end
  }
