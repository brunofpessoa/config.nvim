local M = {}

local HOME = os.getenv("HOME")

M.OBSIDIAN_VAULT = HOME .. "/notes"

M.PROJECTS_DIR = {
    HOME .. "/projetos/*",
    HOME .. "/.config/nvim",
    M.OBSIDIAN_VAULT
}

M.is_work_setup = false

return M
