return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
        version = "v1.10.0",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
				term_colors = true,
				styles = {
					sidebars = "trasnparent",
					floats = "trasnparent",
				},
				integrations = {
					alpha = true,
					treesitter = true,
					neotree = true,
					telescope = { enabled = true },
					which_key = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")

			vim.keymap.set("n", "tt", function()
				local cat = require("catppuccin")
				cat.options.transparent_background = not cat.options.transparent_background
				cat.compile()
				vim.cmd.colorscheme("catppuccin")
			end)
		end,
	},
}
