local bufferline = require('bufferline')
bufferline.setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "undotree",
                text = "Undo Tree",
                text_align = "center",
                separator = true,
            },
        },
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_tab_indicators = true,
        separator_style = "slant"
    }
})
