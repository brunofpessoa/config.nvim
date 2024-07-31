local prey = require('plugins/custom/prey-nvim')
prey.setup()

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

require("lualine").setup({
    options = {
        theme = "ayu_dark",
        globalstatus = true
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics", { "macro-recording", fmt = show_macro_recording } },
        lualine_c = { { prey.get_prey } },
        lualine_x = { "progress" },
        lualine_y = { "datetime", "encoding" },
        lualine_z = { "filename" },
    },
})
