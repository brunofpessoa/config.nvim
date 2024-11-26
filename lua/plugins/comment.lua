return {
    "numToStr/Comment.nvim",
    event = { "InsertEnter" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("Comment").setup({
            toggler = {
                line = "|",
            },
            opleader = {
                line = "|",
            },
            mappings = {
                basic = true,
                extra = false,
            },
        })

        local comment = require("Comment")
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
        comment.setup({
            pre_hook = ts_context_commentstring.create_pre_hook(),
        })
    end
}
