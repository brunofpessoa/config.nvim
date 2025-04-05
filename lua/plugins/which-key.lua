return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
        icons = { mappings = false },
        win = {
            height = { min = 15, max = 50 },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
