return {
    "szw/vim-maximizer",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>wm", "<cmd>MaximizerToggle<CR>", desc = "Maximize buffer" }
    }
}
