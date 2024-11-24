local map = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc or "" })
end

-- Indent block
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Paste without losing the clipboard
map({ "n", "v" }, "<C-p>", '"_dP', "Paste (keep clipboard)")

-- I always press this by accident ;(
map('n', 'q:', '<Nop>')

map("n", "<leader>w", "+Window split", "Vertical split")
map("n", "<leader>ws", "<C-w>v", "Vertical split")
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
map("n", "<leader>s", "", "+Spell checking")
map("n", "<leader>ss", function() require("which-key").show('z=') end, "Spell suggestions")
map("n", "<leader>sa", "zg", "Add word to spell list")
map("n", "<leader>sr", "zw", "Remove word to spell list")
map("n", "<leader>sn", "]s", "Next misspelled word")
map("n", "<leader>sp", "[s", "previus misspelled word")
map("n", "<leader>sf", "1z=", "Chose first spell suggestion")
map("n", "<leader>st",
    function()
        local curr_spell_state = vim.opt.spell:get()
        vim.opt.spell = not curr_spell_state
        require("util.notify").Notify_something("Spellcheck",
            "Spell checking is: " .. (curr_spell_state and "Off" or "On"))
    end,
    "Toggle spell checking"
)
