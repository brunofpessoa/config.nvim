local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}


require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  -- lua
  "lua_ls",
  "stylua",
  -- go
  "gopls",
  "gofumpt",
  "goimports",
  "golines",
  "goimports-reviser",
  -- react
  "tsserver",
  "eslint_d",
  "tailwindcss",
  "emmet-language-server",
  "prettierd",
  -- shells cript
  "bash-language-server",
  "shellcheck",
  -- python
  "pyright",
  "python-lsp-server",
  "black",
  "mypy",
  "ruff",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
  -- :MasonToolsUpdate and :MasonToolsInstall to update or install
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      server.on_attach = require("lsp-format").on_attach
      require("lspconfig")[server_name].setup(server)
    end,
  },
})

require("lspconfig").gdscript.setup(capabilities)
