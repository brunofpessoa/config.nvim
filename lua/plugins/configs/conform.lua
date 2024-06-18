require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
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
