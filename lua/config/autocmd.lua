vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local keymap = require("util.keymap")

-- Change behavior of the navigation in wrap mode
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
set_wrap_mappings()
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "wrap",
	callback = set_wrap_mappings,
})

local colorschemes = {
    random = false,
    default_markdown = "rose-pine-dawn",
    default_others = "catppuccin-frappe",
    light = {
        "github_light_tritanopia",
        "rose-pine-dawn",
        "catppuccin-latte",
    },
    dark = {
        "rose-pine-moon",
        "catppuccin-frappe",
    }
}

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = false })

local function enable_incremental_selection(enable)
    require('nvim-treesitter.configs').setup({
        incremental_selection = {
            enable = enable,
        }
    })
end

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = { "*" },
    group = augroup,
    desc = "Change colorscheme when in obsidian vault",
    callback = function()
        if vim.uv.cwd() == require('constants').OBSIDIAN_VAULT then
            vim.schedule(function()
                math.randomseed(os.time())
                local idx = math.random(#colorschemes.light)
                vim.cmd.colorscheme(colorschemes.random and colorschemes.light[idx] or colorschemes.default_markdown)
            end)
        else
            vim.schedule(function()
                vim.cmd.colorscheme(colorschemes.default_others)
            end)
        end
    end,
})

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
