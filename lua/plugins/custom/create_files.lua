local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local config = {
	base_dir = "", -- if provided the picker will only show the directories under the base_dir
	always_show_dirs = {}, -- always show theses directories on the list
	recursive = false, -- recursively search for directories
	recursion_max_depth = 5, -- nil if you don't want limit
	default_file_extension = "md",
	file_name_date_format = "%Y-%m-%d_%H-%M-%S",
	picker_opts = {},
}

function M.generate_file_name()
	return os.date(config.file_name_date_format) .. "." .. config.default_file_extension
end

function M.create_file(path, filename)
	local filepath = vim.fn.expand(path .. filename)
	local stat = vim.uv.fs_stat(filepath)
	if stat then
		local confirmar = vim.fn.confirm(
			"This file already exists, do you want to overwrite it?",
			"&Yes\n&No",
			2 -- Default: No
		)
		if confirmar ~= 1 then
			vim.notify("Operation canceled", vim.log.levels.WARN)
			return
		end
	end
	local success = vim.fn.writefile({}, filepath)
	if success == 0 then
		vim.notify("File created at: " .. filepath, vim.log.levels.SUCCESS)
		vim.cmd("tabnew " .. filepath)
	else
		vim.notify("Error creating file: " .. filepath, vim.log.levels.ERROR)
	end
end

function M.search_for_directories(dir, current_depth, max_depth)
	local result = {}
	local fs = vim.uv.fs_scandir(dir)

	while true do
		local name, type = vim.uv.fs_scandir_next(fs)
		if not name then
			break
		end
		if type == "directory" and not name:match("^%.") then
			if not dir:match("/$") then
				dir = dir .. "/"
			end
			local pathname = dir .. name
			table.insert(result, pathname)

			if config.recursive then
				local dirs = {}
				if max_depth == nil then
					dirs = M.search_for_directories(pathname, 0, nil)
				elseif current_depth < max_depth then
					dirs = M.search_for_directories(pathname, current_depth + 1, max_depth)
				end
				vim.list_extend(result, dirs)
			end
		end
	end

	return result
end

function M.handle_create_file(dir)
	if vim.fn.isdirectory(vim.fn.expand(dir)) ~= 1 then
		vim.notify("This directory does not exist: " .. vim.fn.expand(dir), vim.log.levels.ERROR)
		return
	end
	local filename = ""
	local input = vim.fn.input("File name: ")
	if input == "" then
		local confirm = vim.fn.confirm("Create a file with the current date as its name?", "&Yes\n&No", 1)
		if confirm ~= 1 then
			return
		end
		filename = M.generate_file_name()
	else
		filename = input
	end
	M.create_file(dir, filename)
end

function M.main()
	local base_dir
	if config.base_dir == "" then
		base_dir = vim.uv.cwd()
	else
		base_dir = vim.fn.expand(config.base_dir)
	end
	pickers
		.new(config.picker_opts, {
			finder = finders.new_table({
				results = vim.list_extend(
					M.search_for_directories(base_dir, 0, config.recursion_max_depth),
					config.always_show_dirs
				),
			}),
			sorter = conf.generic_sorter(config.picker_opts),
			attach_mappings = function(bufnr)
				actions.select_default:replace(function()
					actions.close(bufnr)
					local selection = action_state.get_selected_entry()[1]
					if not selection:match("/$") then
						selection = selection .. "/"
					end
					M.handle_create_file(selection)
				end)
				return true
			end,
		})
		:find()
end

function M.setup(opts)
	config = vim.tbl_deep_extend("force", config, opts or {})
	vim.api.nvim_create_user_command("QuicklyCreateFile", function()
		M.main()
	end, {})
end

return M
