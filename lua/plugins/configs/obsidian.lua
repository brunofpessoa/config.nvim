local OBSIDIAN_VAULT = require('constants').OBSIDIAN_VAULT

vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
        local current_dir = vim.fn.expand('%:h')
        if string.find(current_dir, OBSIDIAN_VAULT) then
            require('nvim-treesitter.configs').setup({
                incremental_selection = {
                    enable = false,
                }
            })
        end
    end,
})

require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = OBSIDIAN_VAULT,
        },
    },

    mappings = {
        ["gd"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<cr>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },

    follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
    end,
})
