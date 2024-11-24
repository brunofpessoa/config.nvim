return {
    "phaazon/hop.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>j", "<cmd>HopWord<CR>", desc = "Hop to word" }
    },
    config = true,
}
