local M = {
	cmd = "sudo",
}

function M.setup(opts)
	opts = opts or {}
	M.cmd = opts.cmd or M.cmd

	vim.api.nvim_create_user_command("SuWrite", M.save_file, {})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = M.save_file,
	})
end

local function can_write(file)
	return vim.loop.fs_access(file, "W")
end

function M.privileged_write(filepath)
	local tempname = vim.fn.tempname()
	vim.api.nvim_command("write! " .. tempname)

	local cmd = string.format("%s cp %s %s", M.cmd, tempname, filepath)
	M.run_terminal(cmd, tempname)
end

function M.save_file()
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)

	if can_write(filepath) then
		vim.api.nvim_command("write")
	else
		M.privileged_write(filepath)
	end
end

function M.run_terminal(cmd, tempname)
	local Terminal = require("toggleterm.terminal").Terminal
	local term = Terminal:new({
		cmd = cmd,
		direction = "float",
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function(term)
			vim.cmd("startinsert!")
			vim.cmd("checktime")
			vim.fn.delete(tempname)
		end,
	})

	term:toggle()
end

return M
