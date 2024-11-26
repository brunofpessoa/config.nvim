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
    keys = {
        { "<leader>o",  "",                             desc = "+Obsidian" },
        { "<leader>on", ":ObsidianNew<cr>",             desc = "New Note" },
        { "<leader>oN", ":ObsidianNewFromTemplate<cr>", desc = "New Note (Template)" },
        { "<leader>ot", ":ObsidianTemplate<cr>",        desc = "Insert Template" },
        { "<leader>od", ":ObsidianDailies<cr>",         desc = "Dailies" },
    },
    opts = {
        ui = { enable = false },
        workspaces = {
            {
                name = "personal",
                path = OBSIDIAN_VAULT,
            },
        },
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        notes_subdir = "notes",
        daily_notes = {
            folder = "dailies"
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
