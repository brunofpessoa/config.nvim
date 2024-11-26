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
        notify = {
            enabled = true,
        },
        messages = {
            enabled = false,
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader>m",  "",                                             desc = "+Messages (Noice)" },
        { "<leader>ml", function() require("noice").cmd("last") end,    desc = "Last" },
        { "<leader>mh", function() require("noice").cmd("history") end, desc = "History" },
        { "<leader>ma", function() require("noice").cmd("all") end,     desc = "All" },
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
