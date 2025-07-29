return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("plugins.alpha-themes.startify-custom")

    dashboard.file_icons.provider = "devicons"

    alpha.setup(dashboard.opts)
  end,
}
