local config = {}

function config.context_vt()
	require("nvim_context_vt").setup({
		enabled = true,
		disable_ft = { "markdown" },
		disable_virtual_lines = false,
		min_rows = 1,
		min_rows_ft = {},
		custom_parser = function(node, _, _)
			local utils = require("nvim_context_vt.utils")

			local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
			return string.format(" -> <%d:%d> %s", start_row + 1, end_row + 1, utils.get_node_text(node)[1])
		end,
	})
end

return config
