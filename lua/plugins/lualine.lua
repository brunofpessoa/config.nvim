local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	end
	return "Recording @" .. recording_register
end

local function count_visual_chars()
  local mode = vim.fn.mode()
  if not (mode:find("v") or mode:find("V") or mode:find("\22")) then
    return "" -- retorna vazio se não estiver no visual mode
  end

  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, {})
  local text = table.concat(lines, "")

  return "Sel: " .. tostring(#text)
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					"diagnostics",
					{ "macro-recording", fmt = show_macro_recording },
				},
				lualine_c = {},
				lualine_x = {
					{
						"searchcount",
						icon = { "󱎸", align = "left" },
					},
					{"location"},
                    { count_visual_chars },
					"encoding",
					"fileformat",
				},
				lualine_y = { "datetime" },
				lualine_z = {
					{
						"filename",
						colored = true,
						icon = { "", align = "left" },
					},
				},
			},
		})
	end,
}
