return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                'go', 'lua', 'python', 'typescript', 'regex',
                'bash', 'markdown', 'markdown_inline', 'sql', 'http',
                'html', 'css', 'javascript', 'yaml', 'json', 'toml',
            },
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            require("ts_context_commentstring").setup({}), -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })

        vim.g.skip_ts_context_commentstring_module = true
    end
}

