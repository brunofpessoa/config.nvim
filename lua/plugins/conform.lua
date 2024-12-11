return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>c", "", desc = "+Code" },
        {
            "<leader>cf",
            function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end,
            mode = { "n", "v" },
            desc = "Format"
        }
    },
    config = function()
        require("conform").setup({
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
                html = { "prettierd" },
                lua = { "stylua" },
                python = { "black" },
                go = {
                    "gofumpt",
                    "goimports",
                    "goimports-reviser",
                    "golines",
                }
            },
        })
    end,
}
