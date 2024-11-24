return {
    "akinsho/toggleterm.nvim",
    event = "VimEnter",
    keys = {
        { "<leader>t",  "<cmd>ToggleTerm direction='float'<CR>", desc = "Abre o terminal integrado" },
        { "<Esc>",      [[<C-\><C-n>]],                          mode = { "t" } },
        { "<Esc><Esc>", "<cmd>ToggleTerm<CR>",                   mode = { "t" } },
    },
    opts = {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.8),
        },
    },
}
