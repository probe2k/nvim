local argc = vim.fn.argc() or 0
if argc > 0 then
	local arg = vim.fn.argv()
	for i = 1, argc do
		if arg[i] == "--headless" then
			return
		end
	end
end

local loader = require("utils.helper").loader

function LazyLoad()
	loader("plenary.nvim")

	loader("nvim-lspconfig")
	vim.cmd "silent! do FileType"

	loader("nvim-treesitter")

	loader("nvim-treesitter-textobjects nvim-treesitter-context")
end

local lazy_timer = 5

vim.defer_fn(function()
	LazyLoad()
	vim.cmd([[ doautocmd User LoadLazyPlugin ]])
end, lazy_timer)

vim.defer_fn(function()
	loader("noice.nvim")
	local gitrepo = vim.fn.isdirectory(".git/index")
	if gitrepo then
		loader("gitsigns.nvim")
	end
	loader("lualine.nvim")
end, lazy_timer + 5)
