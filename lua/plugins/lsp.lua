return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
    },
    keys = {
        { "gd",         require("telescope.builtin").lsp_definitions,      desc = "Definitions" },
        { "gD",         vim.lsp.buf.declaration,                           desc = "Declaration" },
        { "gr",         require("telescope.builtin").lsp_references,       desc = "Reference" },
        { "gi",         require("telescope.builtin").lsp_implementations,  desc = "Implementations" },
        { "gt",         require("telescope.builtin").lsp_type_definitions, desc = "Type Definition" },
        { "K",          vim.lsp.buf.hover,                                 desc = "Details" },
        { "<leader>l",  "",                                                desc = "+Lsp Actions" },
        { "<leader>lr", vim.lsp.buf.rename,                                desc = "Rename" },
        { "<leader>la", vim.lsp.buf.code_action,                           desc = "Code actions" },
        { "<leader>ld", vim.diagnostic.open_float,                         desc = "Diagnostics" },
        { "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>",          desc = "Diagnostics (Telescope)" },
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

        local tools_to_install = {
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
            "lua_ls",
            "stylua",
            "gopls",
            "gofumpt",
            "goimports",
            "golines",
            "goimports-reviser",
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, tools_to_install)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
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
