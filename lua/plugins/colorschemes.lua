return {
    { "projekt0n/github-nvim-theme", },

    { "EdenEast/nightfox.nvim" },

    { "rose-pine/neovim",            name = "rose-pine" },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-frappe")
        end
    },
}
