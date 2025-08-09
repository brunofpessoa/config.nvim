local M = {}

M.set = function(mode, key, action, desc)
	vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc or "" })
end

M.set_all = function (mappings)
    for _, v in ipairs(mappings) do
        M.set(v[1], v[2], v[3], v[4] or "")
    end
end

return M
