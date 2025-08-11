return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = {
			sign = false,
			icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			position = "inline",
			border_virtual = true,
		},
		code = {
			disable_background = true,
			width = "block",
			padding_left = 1,
			border = "thin",
			highlight_language = nil,
			inline = false,
			sign = false,
			language_border = "─",
			above = "─",
			below = "─",
		},
		dash = {
			icon = "──────────  ",
		},
	},
}
