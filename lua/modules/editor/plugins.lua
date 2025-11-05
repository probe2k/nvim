local conf = require("modules.editor.config")

return function(editor)
	editor({ "windwp/nvim-autopairs", config = conf.autopairs, lazy = true })

	editor({ "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeOpen" }, init = conf.nvim_tree_setup, config = conf.nvim_tree })
end
