return {
    "phaazon/hop.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>j", "<cmd>HopWord<CR>", desc = "Hop to Word" }
    },
    config = true,
}
