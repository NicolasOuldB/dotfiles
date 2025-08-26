return {
	"nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/playground",
  },
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "lua", "javascript", "json", "typescript", "tsx", "html", "css", "yaml" },
		highlight = { enable = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
