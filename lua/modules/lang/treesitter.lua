local ts_ensure_installed = { "go", "css", "json", "c", "java", "toml", "tsx", "lua", "cpp", "python", "rust", "yaml", "vim", "markdown", "markdown_inline", "vimdoc", "luadoc" }

local treesitter = function()
	local has_ts = pcall(require, "nvim-treesitter.configs")
	if not has_ts then
		return
	end

	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
			use_languagetree = true,
			disable = { "elm" },
			custom_captures = { todo = "TODO" },
		}
	})
end

local treesitter_obj = function()
	require("nvim-treesitter.configs").setup({
		indent = { enable = true },
		ts_context_commentstring_enabled = true,
		textobjects = {
			lsp_interop = {
				enable = true,
				peek_definition_code = { ["ge"] = "@function.outer", ["gf"] = "@class.outer" },
			}
		},

		ensure_installed = ts_ensure_installed,
	})
end

local treesitter_context = function()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 2,
		trim_scope = "outer",
		mode = "topline",
		patterns = {
			default = { "class", "function", "method", "for", "while", "if", "switch" }
		}
	})

	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#222222", blend = 10 })
end

return {
	treesitter = treesitter,
	treesitter_obj = treesitter_obj,
	treesitter_context = treesitter_context,
	installed = ts_ensure_installed
}
