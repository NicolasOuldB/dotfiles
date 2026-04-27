-- Bootstrap plugins using vim.pack (Neovim 0.12+)
-- Pilot: installs a small core set of plugins and runs their configs.
local plugins = {
  -- plugin manager: keep mason related plugins to manage LSP binaries
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",

  -- UI / colors
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons", -- lualine dependency

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  -- Telescope (fuzzy finder)
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  -- undotree (undo visualizer)
  "https://github.com/jiaoshijie/undotree",
  -- smear-cursor (cursor trail effect)
  "https://github.com/sphamba/smear-cursor.nvim",
  -- smooth scrolling
  "https://github.com/karb94/neoscroll.nvim",
  -- alpha (startup dashboard)
  "https://github.com/goolord/alpha-nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  -- Completions
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rafamadriz/friendly-snippets",
  -- null-ls (optional formatting/diagnostics bridge)
  "https://github.com/nvimtools/none-ls.nvim",
  "https://github.com/nvimtools/none-ls-extras.nvim",
}

-- Add and load plugins
vim.pack.add(plugins, { load = true })

-- Run plugin configuration modules (move config bodies here)
local ok, _ = pcall(require, "config.plugins.gruvbox-material")
if ok then require("config.plugins.gruvbox-material").setup() end

ok, _ = pcall(require, "config.plugins.nvim-lualine")
if ok then require("config.plugins.nvim-lualine").setup() end

ok, _ = pcall(require, "config.plugins.nvim-treesitter")
if ok then require("config.plugins.nvim-treesitter").setup() end

ok, _ = pcall(require, "config.plugins.completions")
if ok then require("config.plugins.completions").setup() end

ok, _ = pcall(require, "config.plugins.none-ls")
if ok then require("config.plugins.none-ls").setup() end

ok, _ = pcall(require, "config.plugins.telescope")
if ok then require("config.plugins.telescope").setup() end

ok, _ = pcall(require, "config.plugins.mason")
if ok then require("config.plugins.mason") end

ok, _ = pcall(require, "config.plugins.undotree")
if ok then require("config.plugins.undotree").setup() end

ok, _ = pcall(require, "config.plugins.smear-cursor")
if ok then require("config.plugins.smear-cursor").setup() end

ok, _ = pcall(require, "config.plugins.neoscroll")
if ok then require("config.plugins.neoscroll").setup() end

ok, _ = pcall(require, "config.plugins.alpha")
if ok then require("config.plugins.alpha").setup() end

-- LSP native config
pcall(require, "config.lsp")

-- Note: vim.pack will create nvim-pack-lock.json in your config dir (XDG) on first run.
-- Commit that lockfile to git if you want deterministic installs across machines.
