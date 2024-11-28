local M = {}

local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local scandir = require("plenary.scandir")

local function get_file_types()
    local extensions = {}
    local seen = {}

    scandir.scan_dir(vim.fn.getcwd(), {
        add_dirs = false,
        depth = 10,
        on_insert = function(file)
            local ext = file:match("^.+%.(.+)$")
            if ext and not seen[ext] then
                seen[ext] = true
                table.insert(extensions, ext)
            end
        end,
    })

    table.sort(extensions)
    return extensions
end

local function select_file_type(on_select)
    local file_types = get_file_types()

    if #file_types == 0 then
        print("Nenhum tipo de arquivo encontrado.")
        return
    end

    pickers.new({}, {
        prompt_title = "Selecionar Tipo de Arquivo",
        finder = finders.new_table({
            results = file_types,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    on_select(selection.value)
                end
            end)
            return true
        end,
    }):find()
end

M.search_string_by_type = function()
    select_file_type(function(file_type)
        builtin.live_grep({
            prompt_title = string.format("Buscar em Arquivos do Tipo: %s", file_type),
            glob_pattern = string.format("*.%s", file_type),
            cwd = vim.fn.getcwd(),
        })
    end)
end

M.search_file_by_type = function()
    select_file_type(function(file_type)
        builtin.find_files({
            prompt_title = string.format("Buscar Arquivos do Tipo: %s", file_type),
            cwd = vim.fn.getcwd(),
            find_command = { "find", ".", "-type", "f", "-name", string.format("*.%s", file_type) },
        })
    end)
end

M.setup = function()
    vim.api.nvim_create_user_command("SearchStringByType", M.search_string_by_type, {})
    vim.api.nvim_create_user_command("SearchFileByType", M.search_file_by_type, {})
end

return M
