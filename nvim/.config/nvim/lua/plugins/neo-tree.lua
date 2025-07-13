return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- Optional image support for file preview: See `# Preview Mode` for more information.
		-- {"3rd/image.nvim", opts = {}},
		-- OR use snacks.nvim's image module:
		-- "folke/snacks.nvim",
	},
	lazy = false,
	config = function()
		vim.keymap.set("n", "<leader>tt", ":Neotree filesystem toggle=true<CR>")

		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			window = {
				mappings = {
					["p"] = {
						"toggle_preview",
						config = {
							use_float = true,
							--use_snacks_image = true,
							--use_image_nvim = true,
						},
					},
				},
			},
		})
	end,
}
