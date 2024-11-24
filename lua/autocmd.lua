local favorites = {
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

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

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
    desc = "Change things when in obsidian vault",
    callback = function()
        local current_dir = vim.fn.expand('%:p')
        if string.find(current_dir, require('constants').OBSIDIAN_VAULT) then
            enable_incremental_selection(true)
        else
            enable_incremental_selection(false)
        end

        vim.schedule(function()
            local file_type = vim.bo.filetype
            if file_type == "markdown" then
                math.randomseed(os.time())
                local idx = math.random(#favorites.light)
                vim.cmd.colorscheme(favorites.random and favorites.light[idx] or favorites.default_markdown)
            else
                vim.cmd.colorscheme(favorites.default_others)
            end
        end)
    end,
})
