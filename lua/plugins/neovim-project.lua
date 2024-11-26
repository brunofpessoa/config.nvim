return {
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
    config = function()
        require("neovim-project").setup({
            projects = require('constants').PROJECTS_DIR,
            last_session_on_startup = false,
            dashboard_mode = true,
        })
    end
}
