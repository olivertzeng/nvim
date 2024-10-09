local M = {}

-- sets main options from options (table)
M.vim_opts = function(options)
	if options ~= nil then
		for scope, table in pairs(options) do
			for setting, value in pairs(table) do
				vim[scope][setting] = value
			end
		end
	end
end

-- sets keybinds
M.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- creating new file for alpha nvim buffer
M.create_new_file = function()
	local filename = vim.fn.input("請輸入檔案名稱：")
	if filename ~= "" then
		vim.cmd("edit " .. filename)
	end
end

-- helper for cmp completion
M.has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- updates all Mason packages
M.update_mason = function()
	local registry = require("mason-registry")
	registry.refresh()
	registry.update()
	local packages = registry.get_all_packages()
	for _, pkg in ipairs(packages) do
		if pkg:is_installed() then
			pkg:install()
		end
	end
end

-- check if attached lsp supports formatting
M.supports_formatting = function()
	local clients = vim.lsp.get_clients()
	for _, client in ipairs(clients) do
		if client.supports_method("textDocument/formatting") then
			return true
		end
	end
	return false
end

return M
