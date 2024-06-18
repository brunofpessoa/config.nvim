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
    -- disabled_filetypes = { "undotree", "neo-tree" },
    globalstatus = true
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      { "macro-recording", fmt = show_macro_recording },
    },
    lualine_x = { "diff" },
    lualine_y = { "datetime" },
    lualine_z = { "filename" },
  },
})
