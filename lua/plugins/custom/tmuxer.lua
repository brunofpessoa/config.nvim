local M = {}

M.defaults = {
	mode = "split", -- "split" ou "float"
	float = {
		width = 0.8,
		height = 0.8,
		border = "rounded",
	},
	split = {
		size = 15,
	},
}

local function in_tmux()
	return vim.env.TMUX and vim.env.TMUX ~= ""
end

local function close_win_and_buf(win, buf)
	if win and vim.api.nvim_win_is_valid(win) then
		pcall(vim.api.nvim_win_close, win, true)
	end
	if buf and vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.api.nvim_buf_delete, buf, { force = true })
	end
end

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

	vim.api.nvim_create_user_command("Tmuxer", function()
		M.run_tmuxer()
	end, {})
end

function M.run_tmuxer()
	if not in_tmux() then
		vim.notify("[Tmuxer] Você não está dentro de uma sessão do tmux.", vim.log.levels.WARN)
		return
	end

	if M.options.mode == "float" then
		M.open_float()
	else
		M.open_split()
	end
end

function M.open_split()
	vim.cmd("botright new") -- janela + buffer novos
	vim.cmd("resize " .. M.options.split.size)
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buflisted = false
	M.start_terminal(buf, win)
end

function M.open_float()
	local width = math.floor(vim.o.columns * M.options.float.width)
	local height = math.floor(vim.o.lines * M.options.float.height)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = M.options.float.border,
	})

	vim.bo[buf].buflisted = false
	M.start_terminal(buf, win)
end

function M.start_terminal(buf, win)
	-- Garante que o buffer alvo está ativo antes do termopen
	if buf and vim.api.nvim_buf_is_valid(buf) then
		vim.api.nvim_set_current_buf(buf)
	end

	local job = vim.fn.termopen("tmuxer", {
		on_exit = function(_, code, _)
			vim.schedule(function()
				close_win_and_buf(win, buf)
				if code ~= 0 then
					vim.notify(string.format("[Tmuxer] Processo finalizado (código %d).", code), vim.log.levels.WARN)
				end
			end)
		end,
	})

	-- Fecha automaticamente quando o terminal fechar (reforço ao on_exit)
	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		once = true,
		callback = function()
			vim.schedule(function()
				close_win_and_buf(win, buf)
			end)
		end,
	})

	-- <Esc><Esc> encerra o job e fecha a janela/buffer
	local keymap_opts = { noremap = true, silent = true, buffer = buf }
	vim.keymap.set("t", "<Esc><Esc>", function()
		if job and job > 0 then
			pcall(vim.fn.jobstop, job)
		end
		close_win_and_buf(win, buf)
	end, keymap_opts)

	-- Entra no modo terminal (útil quando tmuxer não troca de sessão instantaneamente)
	vim.cmd("startinsert")
end

return M
