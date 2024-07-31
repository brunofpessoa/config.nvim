require("oil").setup({
    keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gs"] = "actions.change_sort",
        ["<C-h>"] = "actions.toggle_hidden",
    },
    float = {
        padding = 4,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
            winblend = 0,
        },
        override = function(conf)
            return conf
        end,
    },
    view_options = {
        show_hidden = true,
    },
    use_default_keymaps = false,
})
