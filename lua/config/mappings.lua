local mappings = {
	{ "n", "<C-Left>", "<C-w><", "Increase width" },
	{ "n", "<C-Right>", "<C-w>>", "Decrease width" },
	{ "n", "<leader>w", ":set wrap!<CR>", "Toggle wrap" },
	{ "v", "J", ":m '>+1<CR>gv=gv", "Move selection Down" },
	{ "v", "K", ":m '<-2<CR>gv=gv", "Move selection Up" },
    { "n", "<leader>n", ":nohl<CR>", "Clear highlights" },
    { "n", "<esc>", ":nohl<CR>", "Clear highlights" },
    { "n", "<leader>sa", "zg", "Add word to dictionary" },
	{ "n", "<leader>sr", "zw", "Remove word from Dictionary" },
	{ "n", "<leader>sn", "]s", "Go to next misspelled word" },
	{ "n", "<leader>sp", "[s", "Go to previus misspelled word" },
	{ "n", "<leader>sf", "1z=", "Accept First spell suggestion" },
	{ { "n", "v" }, "<C-p>", '"_dP', "Paste (keep clipboard)" },
	{ "n", "<M-j>", "<cmd>cnext<cr>", "Next item in Quick Fix list" },
	{ "n", "<M-k>", "<cmd>cprev<cr>", "Previous item in Quick Fix list" },
	{ "n", "<leader>z", ":ZenMode<cr>", "Toggle zen mode" },
}

local remaps = {
    { "n", "Q", "<nop>" }, -- Disable replay of macros
    { "n", "q:", "<nop>" }, -- I always press this by accident ;(
	{ "x", "y", "ygv<Esc>" }, -- Keep cursor position after yank in visual mode
	{ "n", "<C-d>", "<C-d>zz" }, -- Center view after scroll down
	{ "n", "<C-u>", "<C-u>zz" }, -- Center view after scroll up
	{ "n", "n", "nzzzn" }, -- Center view after reach the next search occurrence
	{ "n", "N", "Nzzzn" }, -- Center view after reach the previous search occurrence
	{ "n", "H", "^" },
	{ "n", "L", "$" },
    { "v", "<", "<gv"},
    { "v", ">", ">gv"},
}

local keymaps = require("util.keymap")

keymaps.set_all(mappings)
keymaps.set_all(remaps)
