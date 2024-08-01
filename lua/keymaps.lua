local map = function(mode, key, action)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true })
end

map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

map({ "n", "v" }, "<leader>p", '"_dP')

map('n', 'q:', '<Nop>')

map("n", "<leader>ws", "<C-w>v") -- split vertically
map("n", "<leader>wm", "<cmd>MaximizerToggle<CR>")

-- Keep cursor at position when yanking
map("x", "y", "ygv<Esc>")

-- Move selection
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Center view
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzn")
map("n", "N", "Nzzzn")

-- Clear search highlights
map("n", "<leader>n", ":nohl<CR>")

-- Neo tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
map("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<CR>")

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.git_files)
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")
map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm direction='float'<CR>")
map("t", "<Esc>", [[<C-\><C-n>]])
map("t", "<Esc><Esc>", "<cmd>ToggleTerm<CR>")

-- Undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- TODO comments
map("n", "<leader>c", "<cmd>TodoTelescope<CR>")

-- Hop
map("n", "<leader>j", "<cmd>HopWord<CR>")

-- LSP
map("n", "gd", require("telescope.builtin").lsp_definitions)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gr", require("telescope.builtin").lsp_references)
map("n", "gi", require("telescope.builtin").lsp_implementations)
map("n", "gt", require("telescope.builtin").lsp_type_definitions)
map("n", "<leader>r", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>")

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
map("n", "<leader>ha", mark.add_file)
map("n", "<leader>hl", ui.toggle_quick_menu)
map("n", "<leader>ht", "<cmd>Telescope harpoon marks<CR>")
for i = 1, 4 do
    map("n", "<leader>" .. i, function()
        ui.nav_file(i)
    end)
end

-- Conform
map("n", "<C-S-I>", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end)

map("v", "<C-I>", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end)

-- Project manager
map("n", "<leader>m", "<cmd>Telescope neovim-project discover<cr>")

map("n", "<leader>o", require("oil").toggle_float)

-- Neoscroll
local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150", nil } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150", nil } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "300", [['circular']] } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "300", [['circular']] } }
t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
t["zt"] = { "zt", { "200" } }
t["zz"] = { "zz", { "200" } }
t["zb"] = { "zb", { "200" } }

require("neoscroll.config").set_mappings(t)

local function set_wrap_mappings()
    if vim.wo.wrap then
        vim.o.linebreak = true
        vim.o.wrapmargin = 2
        map('n', 'j', 'gj')
        map('n', 'k', 'gk')
        map("n", "H", "g^")
        map("n", "L", "g$")
    else
        map("n", "H", "^")
        map("n", "L", "$")
    end
end
set_wrap_mappings()
vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'wrap',
    callback = set_wrap_mappings
})

-- lazygit
map("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- Tab bar
map("n", "+", "<cmd>BufferLineCycleNext<CR>")
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
map("n", "_", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<leader>q", "<cmd>bdelete<CR>")
map("n", "<leader>Q", "<cmd>BufferLineCloseOthers<CR>")
