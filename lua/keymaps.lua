local map = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc or "" })
end

-- Change Width of Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")

-- Indent block
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Paste without losing the clipboard
map({ "n", "v" }, "<C-p>", '"_dP', "Paste (keep clipboard)")

-- I always press this by accident ;(
map('n', 'q:', '<Nop>')

map("n", "<leader>w", "", "+Window")
map("n", "<leader>wv", "<C-w>v", "Vertical split")
map("n", "<leader>ws", "<C-w>s", "Horizontal split")

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
map("n", "<leader>n", ":nohl<CR>", "Clean Highlights")

-- Change behavior of the navigation in wrap mode
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

-- Spell checking
map("n", "<leader>s", "", "+Spell Checking")
map("n", "<leader>ss", function() require("which-key").show('z=') end, "Spell Suggestions")
map("n", "<leader>sa", "zg", "Add To Dictionary")
map("n", "<leader>sr", "zw", "Remove From Dictionary")
map("n", "<leader>sn", "]s", "Next Misspelled")
map("n", "<leader>sp", "[s", "previus Misspelled")
map("n", "<leader>sf", "1z=", "Accept First")
map("n", "<leader>st",
    function()
        local curr_spell_state = vim.opt.spell:get()
        vim.opt.spell = not curr_spell_state
        require("util.notify").Notify_something("Spellcheck",
            "Spell checking is: " .. (curr_spell_state and "Off" or "On"))
    end,
    "Toggle Spell Checking"
)
