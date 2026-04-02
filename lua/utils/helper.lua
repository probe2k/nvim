local M = { log_path = vim.lsp.log.get_filename() }

function M.loader(modules)
	local lazy = require("lazy")
	if type(modules) == "string" then
		modules = vim.fn.split(modules, " ")
	end
	lazy.load({ plugins = modules })
end

return M
