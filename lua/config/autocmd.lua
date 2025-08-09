-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local keymap = require("util.keymap")

local function set_wrap_mappings()
	if vim.wo.wrap then
		vim.o.linebreak = true
		vim.o.wrapmargin = 2
        keymap.set_all({
            { "n", "j", "gj" },
            { "n", "k", "gk" },
            { "n", "H", "g^" },
            { "n", "L", "g$" },
        })
	else
        keymap.set_all({
            { "n", "H", "^" },
            { "n", "L", "$" },
        })
	end
end

-- Change behavior of the navigation in wrap mode
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "wrap",
	callback = set_wrap_mappings,
})

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = false })

local function enable_incremental_selection(enable)
    require('nvim-treesitter.configs').setup({
        incremental_selection = {
            enable = enable,
        }
    })
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*" },
    group = augroup,
    desc = "Toggle incremental selection when in obsidian vault",
    callback = function()
        if vim.bo.filetype == "markdown" then
            enable_incremental_selection(false)
        else
            enable_incremental_selection(true)
        end
    end,
})
