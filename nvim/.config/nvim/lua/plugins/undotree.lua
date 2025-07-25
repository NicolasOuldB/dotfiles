return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	keys = { -- load the plugin only when using it's keybinding:
		{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	},
	config = function()
		local undotree = require("undotree")
		undotree.setup({
			position = "right",
		})
		vim.keymap.set("n", "<leader>u", undotree.toggle, { noremap = true, silent = true })
	end,
}
