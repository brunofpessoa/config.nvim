-- run `MasonToolsInstall` to install tools

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
        { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>",          desc = "Diagnostics bufnr=0" },
		{ "<leader>lD", "<cmd>Telescope diagnostics<CR>",                  desc = "Diagnostics all buffers" },
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        require("mason").setup()

        local ensure_installed = {
            "ts_ls",
            -- "angular-language-server",
            "emmet-language-server",
            "prettierd",
            "bash-language-server",
            "shfmt",
            "lua_ls",
            "stylua",
            "gopls",
            "gofumpt",
            "goimports",
            "golines",
            "goimports-reviser",
            "chrome-debug-adapter",
            "go-debug-adapter",
            "delve",
            "arduino_language_server",
        }

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_enable = true;
            handlers = {
                function(server_name)
                    local server = {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        require("lspconfig").gdscript.setup(capabilities)

        require("lspconfig")["arduino_language_server"].setup({
            cmd = {
                vim.fn.expand("~/.local/share/nvim/mason/bin/arduino-language-server"),
                "-clangd",
                "clangd",
                "-cli",
                "/usr/bin/arduino-cli",
                "-cli-config",
                vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
                "-fqbn",
                "esp32:esp32:esp32",
            },
            -- capabilities = capabilities, <-- DO NOT specify that
        })
    end
}
