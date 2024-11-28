return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
        { "<space>fb", "<cmd>Telescope file_browser<CR>",                               desc = "File Browser" },
        { "<space>fB", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Browser (Select Buffer)" }
    },
}
