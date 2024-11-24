local ui = require("util.ui")

return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    keys = {
        { "+",         "<cmd>BufferLineCycleNext<CR>",   desc = "Cycle buffers (next)" },
        { "<Tab>",     "<cmd>BufferLineCycleNext<CR>",   desc = "Cycle buffers (next)" },
        { "_",         "<cmd>BufferLineCyclePrev<CR>",   desc = "Cycle buffers (previous)" },
        { "<S-Tab>",   "<cmd>BufferLineCyclePrev<CR>",   desc = "Cycle buffers (previous)" },
        { "<leader>q", ui.bufremove,                     desc = "Close current buffer" },
        { "<leader>Q", "<cmd>BufferLineCloseOthers<CR>", desc = "CLose other buffers" },
    },
    opts = {
        options = {
            indicator = {
                style = 'none'
            },
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = false,
                },
                {
                    filetype = "undotree",
                    text = "Undo Tree",
                    text_align = "center",
                    separator = false,
                },
            },
            diagnostics = "nvim_lsp",
            diagnostics_update_on_event = true,
            separator_style = "slope",
        }
    }
}
