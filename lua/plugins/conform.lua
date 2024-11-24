return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<C-S-I>", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end, desc = "Formatar todo o código" },
        { "<C-I>", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end, mode = {"v"}, desc = "Formatar todo o código" }
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
                javascript = { { "prettierd", "estlint_d" } },
                typescript = { { "prettierd", "estlint_d" } },
                javascriptreact = { { "prettierd", "estlint_d" } },
                typescriptreact = { { "prettierd", "estlint_d" } },
                css = { { "prettierd" } },
                json = { { "prettierd" } },
                html = { { "prettierd" } },
                yaml = { { "prettierd" } },
            },
        })
    end,
}
