return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
    },
    keys = {
        { "gd",         require("telescope.builtin").lsp_definitions },
        { "gD",         vim.lsp.buf.declaration },
        { "gr",         require("telescope.builtin").lsp_references },
        { "gi",         require("telescope.builtin").lsp_implementations },
        { "gt",         require("telescope.builtin").lsp_type_definitions },
        { "<leader>r",  vim.lsp.buf.rename,                               desc = "Rename (LSP)" },
        { "<leader>ca", vim.lsp.buf.code_action,                          desc = "Code actions" },
        { "K",          vim.lsp.buf.hover },
        { "<leader>d",  vim.diagnostic.open_float,                        desc = "Diagnostics" },
        { "<leader>D",  "<cmd>Telescope diagnostics bufnr=0<CR>",         desc = "Diagnostics (Telescope)" },
    },
    config = function()
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

        local function get_tools_list()
            return {
                "ts_ls",
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
                "tailwindcss-language-server",
                "lua_ls",
                "stylua",
                "gopls",
                "gofumpt",
                "goimports",
                "golines",
                "goimports-reviser",
            }
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
    end
}
