local builtin = require("telescope.builtin")

return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>f",  "",                                           desc = "+Find everything" },
        { "<leader>ff", builtin.find_files,                           desc = "Find Files" },
        { "<leader>fg", builtin.git_files,                            desc = "Find Git Files" },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                desc = "Find Recent Files" },
        { "<leader>fs", "<cmd>Telescope live_grep<CR>",               desc = "Live String" },
        { "<leader>fc", builtin.colorscheme,                          desc = "Colorscheme" },
        { "<leader>fp", "<cmd>Telescope neovim-project discover<cr>", desc = "Find Project" },
        { "<leader>ft", "<cmd>TodoTelescope<CR>",                     desc = "Find TODOs" },
        { "<leader>fm", function() require("noice").cmd("pick") end,  desc = "Find Editor Messages" },
        { "<leader>fo", ":ObsidianTags",                              desc = "Find Obsidian (tags)" },
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
                    }
                })
            end
            require("notify")("Ignorar arquivos de teste: " .. tostring(ignore_test_files), "info",
                { title = "Telescope" })
        end

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                    },
                },
                layout_strategy = "horizontal",
                preview = {
                    hide_on_startup = false,
                },
                layout_config = {
                    horizontal = {
                        width = 0.9,
                        preview_width = 0.5,
                    },
                },
                file_ignore_patterns = file_ignore_patterns,
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                    ignore_builtins = false,
                }
            }
        })

        telescope.load_extension("fzf")

        vim.keymap.set('n', '<leader>i', "", { desc = "+Ignore" })
        vim.keymap.set('n', '<leader>it', toggle_test_file_ignore, { desc = "Ignore test files in Telescope" })
    end
}
