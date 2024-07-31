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
            }
        })
    else
        telescope.setup({
            defaults = {
                file_ignore_patterns = {},
            }
        })
    end
    require("notify")("Ignorar arquivos de teste: " .. tostring(ignore_test_files), "info", { title = "Telescope" })
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
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")

vim.keymap.set('n', '<leader>it', toggle_test_file_ignore)
