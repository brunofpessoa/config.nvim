return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" }
    },
    opts = {}
}
