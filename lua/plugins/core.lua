local conf = "plugins.configs."

local config = function(pluginName)
    return function()
        require(conf .. pluginName)
    end
end

return {

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",       opts = {} },
        },
        config = config("lsp"),
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
        },
        build = ":TSUpdate",
        config = config("treesitter"),
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        config = config("cmp"),
    },

    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
        },
        config = config("telescope"),
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = config("nvim-tree"),
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },

    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = config("conform"),
    },

    {
        "phaazon/hop.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = config("lualine"),
    },

    {
        "szw/vim-maximizer",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "karb94/neoscroll.nvim",
        config = true,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = config("noice"),
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = config("autopairs"),
    },

    {
        "coffebar/neovim-project",
        init = function()
            vim.opt.sessionoptions:append("globals")
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
        config = config("project-manager"),
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },

    {
        "akinsho/toggleterm.nvim",
        event = "VimEnter",
        opts = {
            float_opts = {
                border = "curved",
                width = math.floor(vim.o.columns * 0.9),
                height = math.floor(vim.o.lines * 0.8),
            },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = config("todo-comments")
    },

    {
        "mbbill/undotree",
        event = "InsertEnter",
    },

    {
        "mg979/vim-visual-multi",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "ThePrimeagen/harpoon",
        config = config("harpoon"),
    },

    {
        "alexghergh/nvim-tmux-navigation",
        config = config("tmux-navigator"),
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = config("bufferline")
    },

}
