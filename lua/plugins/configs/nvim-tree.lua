local nvimtree = require("nvim-tree")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
    view = {
        width = 35,
        relativenumber = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                folder_arrow = false,
            },
            git_placement = "after",
            glyphs = {
                git = {
                    unstaged = "~",
                    staged = "+",
                    unmerged = "",
                    renamed = "",
                    untracked = "?",
                    deleted = "-",
                    ignored = "◌",
                },
            },
        },
    },
    git = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = false,
    }
})
