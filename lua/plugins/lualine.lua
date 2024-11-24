local prey = require('plugins/custom/prey-nvim')
prey.setup()

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    end
    return "Recording @" .. recording_register
end

local function show_kanula_env()
    local file_type = vim.bo.filetype
    if file_type == "http" then
        return "Kanula: " .. require('kulala').get_selected_env()
    end
    return ""
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = 'auto',
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                    { "macro-recording", fmt = show_macro_recording }
                },
                lualine_c = { { prey.get_prey } },
                lualine_x = {
                    { "kanula_env", fmt = show_kanula_env },
                    { "neovim", fmt = function() return "" end },
                    {
                        "searchcount",
                        icon = { "󱎸", align = "left" }
                    },
                    "encoding"
                },
                lualine_y = { "datetime" },
                lualine_z = {
                    {
                        "filename",
                        colored = true,
                        icon = { '', align = 'left' }
                    }
                },

            },
        })
    end,
}
