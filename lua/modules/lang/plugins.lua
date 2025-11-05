local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

return function(lang)
	lang({ "nvim-treesitter/nvim-treesitter", lazy = true, config = ts.treesitter, module = false })

	lang({ "nvim-treesitter/nvim-treesitter-textobjects", config = ts.treesitter_obj, module = false, lazy = true })

	lang({ "nvim-treesitter/nvim-treesitter-context", lazy = true, config = ts.treesitter_context, module = false })

	lang({ "haringsrob/nvim_context_vt", lazy = true, event = { "CursorHold", "WinScrolled", "CursorMoved" }, config = conf.context_vt })
end
