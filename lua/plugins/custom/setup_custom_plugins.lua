local custom_plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins/custom/"

return {

    {
        dir = custom_plugins_dir .. "quick_push",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>ob", "<cmd>AddCommitPush<cr>", desc = "Backup vault (Git)" }
        },
        config = function()
            require("plugins.custom.quick_push").setup({
                git_dir = vim.fn.expand(require("constants").OBSIDIAN_VAULT),
            })
        end,
    },

    {
        dir = custom_plugins_dir .. "prayer",
        keys = {
            { "<C-S-o>", "<cmd>PrayerUpdate<cr>", desc = "Update Prayer" }
        },
        config = function()
            require('plugins/custom/prayer').setup({
                show_in_lualine = false,
            })
        end
    },

    {
        dir = custom_plugins_dir .. "search_by_type",
        keys = {
            { "<leader>fS", "<cmd>SearchStringByType<cr>", desc = "String By File Type" },
            { "<leader>fF", "<cmd>SearchFileByType<cr>",   desc = "File By Type" },
        },
        config = function()
            require("plugins.custom.search_by_type").setup()
        end
    }

}
