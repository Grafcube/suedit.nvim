local M = {
	cmd = "sudo",
}

function M.setup(opts)
	opts = opts or {}
	M.cmd = opts.cmd or M.cmd

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = M.save_file,
	})
end

function M.save_file()
	vim.notify(
		"Your version of `suedit.nvim` will no longer receive updates. Please change your plugin config to use `<https://codeberg.org/grafcube/suedit.nvim>`",
		vim.log.levels.ERROR
	)
end
