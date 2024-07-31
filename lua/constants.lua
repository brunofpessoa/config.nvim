local M = {}

local HOME = vim.fn.expand("~")

M.OBSIDIAN_VAULT = HOME .. "/sweet-home/Documents/Obsidian/Bruno"

M.PROJECTS = {
    HOME .. "/workspace/*",
    HOME .. "/.dotfiles",
    M.OBSIDIAN_VAULT
}

return M
