local conf = require("modules.completion.config")

return function(comp)
	comp({
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = { "Telescope" },
		dependencies = { { "nvim-lua/plenary.nvim", lazy = true }, { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, { "nvim-tree/nvim-web-devicons" } },
		init = conf.telescope_preload,
		config = conf.telescope
	})

	comp({
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets", module = false, lazy = true }, lazy = true },
			{ "hrsh7th/cmp-buffer", lazy = true },
			{ "hrsh7th/cmp-nvim-lua", lazy = true },
			{ "hrsh7th/cmp-nvim-lsp", lazy = true },
			{ "hrsh7th/cmp-path", lazy = true },
			{ "hrsh7th/cmp-cmdline", lazy = true },
			{ "dmitmel/cmp-cmdline-history", lazy = true },
			{ "hrsh7th/cmp-emoji", lazy = true },
			{ "ray-x/cmp-treesitter", lazy = true },
			{ "saadparwaiz1/cmp_luasnip", lazy = true },
		},
		config = conf.nvim_cmp
	})

	comp({
		"williamboman/mason.nvim",
		cmd = { "Mason" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		module = false,
		config = conf.mason
	})

	comp({
		"neovim/nvim-lspconfig",
		config = conf.nvim_lsp,
		lazy = true
	})
end
