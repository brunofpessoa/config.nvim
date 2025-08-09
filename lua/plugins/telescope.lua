local builtin = require("telescope.builtin")

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>f", "", desc = "+Find everything" },
		{ "<leader>ff", builtin.find_files, desc = "Files" },
		{ "<leader>fg", builtin.git_files, desc = "Git Files" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
		{ "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "String" },
		{ "<leader>fc", builtin.colorscheme, desc = "Colorscheme" },
		{ "<leader>fp", "<cmd>Telescope neovim-project discover<cr>", desc = "Project" },
		{ "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "TODOs" },
		{
			"<leader>fm",
			function()
				require("noice").cmd("pick")
			end,
			desc = "Messages",
		},
		{ "<leader>fo", ":ObsidianTags<cr>", desc = "Obsidian (tags)" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local ignore_test_files = true
		local file_ignore_patterns = { "%.test%.*", "%.spec%.*" }

		local function toggle_test_file_ignore()
			ignore_test_files = not ignore_test_files
			if ignore_test_files then
				telescope.setup({
					defaults = {
						file_ignore_patterns = file_ignore_patterns,
					},
				})
			else
				telescope.setup({
					defaults = {
						file_ignore_patterns = {},
					},
				})
			end
			require("notify")(
				"Ignorar arquivos de teste: " .. tostring(ignore_test_files),
				"info",
				{ title = "Telescope" }
			)
		end

		telescope.setup({
			defaults = {
				winblend = 0,
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
				layout_strategy = "vertical",
				preview = {
					hide_on_startup = false,
				},
				layout_config = {
					horizontal = {
						width = 0.9,
						preview_width = 0.5,
					},
                    vertical = {
						preview_height = 0.6,
                    }
				},
				file_ignore_patterns = file_ignore_patterns,
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
					ignore_builtins = false,
				},
			},
		})

		vim.keymap.set("n", "<leader>i", "", { desc = "+Ignore" })
		vim.keymap.set("n", "<leader>it", toggle_test_file_ignore, { desc = "Ignore test files in Telescope" })
	end,
}
