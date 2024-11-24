local M = {}

local HOME = vim.fn.expand("~")

M.OBSIDIAN_VAULT = HOME .. "/pessoal/obsidian/vault"

M.PROJECTS_DIR = {
    HOME .. "/projetos/*",
    HOME .. "/.config/*",
    M.OBSIDIAN_VAULT
}

M.is_work_setup = false

return M
