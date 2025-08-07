local M = {}

local HOME = vim.fn.expand("~")

M.OBSIDIAN_VAULT = HOME .. "/vault"

M.PROJECTS_DIR = {
    HOME .. "/projetos/*",
    HOME .. "/.config/nvim",
    M.OBSIDIAN_VAULT
}

M.is_work_setup = false

return M
