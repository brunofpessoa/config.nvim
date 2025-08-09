vim.g.mapleader = " "

local options = {
	number = true,
	relativenumber = true,
	wrap = false,
	scrolloff = 15,
	sidescrolloff = 30,
	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	smartcase = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	autoindent = true,
	swapfile = false,
	backup = false,
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true,
	autoread = true,
	cursorline = true,
	termguicolors = true,
	mouse = "a",
	clipboard = "unnamedplus",
	fillchars = { eob = " " },
	cmdheight = 0,
	spelllang = { "pt_br", "en" },
	spell = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
