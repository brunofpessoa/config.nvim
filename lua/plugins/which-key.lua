return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		icons = { mappings = false },
		win = {
			height = { min = 15, max = 50 },
		},
	},
}
