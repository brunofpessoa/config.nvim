-- return {
--     "folke/noice.nvim",
--     event = "VeryLazy",
--     dependencies = {
--         "MunifTanjim/nui.nvim",
--         "rcarriga/nvim-notify",
--     },
--     opts = {
--         lsp = {
--             override = {
--                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--                 ["vim.lsp.util.stylize_markdown"] = true,
--                 ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--             },
--         },
--         -- notify = {
--         --     enabled = false,
--         -- },
--         messages = {
--             enabled = false,
--         },
--         presets = {
--             bottom_search = false,     -- use a classic bottom cmdline for search
--             command_palette = true,   -- position the cmdline and popupmenu together
--             long_message_to_split = true, -- long messages will be sent to a split
--             inc_rename = false,       -- enables an input dialog for inc-rename.nvim
--             lsp_doc_border = true,    -- add a border to hover docs and signature help
--         },
--     }
-- }

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader>m",  "",                                             desc = "+noice" },
        { "<leader>ml", function() require("noice").cmd("last") end,    desc = "Noice Last Message" },
        { "<leader>mh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>ma", function() require("noice").cmd("all") end,     desc = "Noice All" },
        { "<leader>md", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
        { "<leader>mt", function() require("noice").cmd("pick") end,    desc = "Noice Picker (Telescope/FzfLua)" },
        { "<leader>mc", function() require("noice").cmd("dismiss") end, desc = "Clear messages" },
    },
    config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,
}
