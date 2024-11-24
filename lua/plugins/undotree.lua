return {
    "mbbill/undotree",
    event = "InsertEnter",
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Arvore de modificações (Undotree)" }
    }
}
