local map = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc or "" })
end

require('plugins.custom.prayer').setup({ show_in_lualine = false })
map("n", "<C-S-o>", "<cmd>PrayerUpdate<cr>", "Update Prayer")

require('plugins.custom.quick_push').setup({ git_dir = require('constants').OBSIDIAN_VAULT })
map("n", "<leader>ob", "<cmd>AddCommitPush<cr>", "Backup vault (Git)")

require('plugins.custom.search_by_type').setup()
map("n", "<leader>fS", "<cmd>SearchStringByType<cr>", "String By File Type")
map("n", "<leader>fF", "<cmd>SearchFileByType<cr>", "File By Type")
