local OBSIDIAN_VAULT = require('constants').OBSIDIAN_VAULT

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    event = {
        "BufReadPre " .. OBSIDIAN_VAULT .. '/**.md',
        "BufNewFile " .. OBSIDIAN_VAULT .. '/**.md',
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        ui = { enable = false },
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
    }
}
