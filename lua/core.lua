local opt = vim.opt

vim.g.mapleader = " "

opt.number = true
opt.relativenumber = true

opt.scrolloff = 8
opt.sidescrolloff = 20

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
vim.g.disable_autoformat = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.cursorline = true
opt.termguicolors = true

opt.mouse:append("a")
opt.clipboard:append("unnamedplus")

opt.fillchars:append({ eob = " " })

opt.cmdheight = 0

vim.o.wrap = false

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 300,
        })
    end,
})

-- If error manually download it in: https://ftp.nluug.nl/pub/vim/runtime/spell/pt.utf-8.spl
-- File location: ~/.config/nvim/spell
opt.spelllang = {"pt_br",   "en"}
opt.spell = true

-- needed for .http files (kanula http client)
vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

