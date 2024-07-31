local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
local constants = require("constants")

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

local function get_tools_list()
    local tools = {
        "tsserver",
        "angular-language-server",
        "emmet-language-server",
        "prettierd",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "pyright",
        "python-lsp-server",
        "black",
        "mypy",
        "ruff",
    }
    if not constants.work_setup then
        table.insert(tools, {
            "lua_ls",
            "stylua",
            "gopls",
            "gofumpt",
            "goimports",
            "golines",
            "goimports-reviser",
            "eslint_d",
            "tailwindcss-language-server",
        })
    end
    return tools
end

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, get_tools_list())
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
    -- :MasonToolsUpdate and :MasonToolsInstall to update or install
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end,
    },
})

require("lspconfig").gdscript.setup(capabilities)
