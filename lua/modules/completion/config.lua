local config = {}

function config.telescope_preload()
	require("utils.helper").loader({ "plenary.nvim" })
end

function config.nvim_lsp()
	require("modules.completion.lsp")
end

function config.telescope()
	local actions = require("telescope.actions")

	require("telescope").setup({
		pickers = {
			find_files = { disable_devicons = false }
		},
		defaults = {
			layout_strategy = "horizontal",
			sorting_strategy = "ascending",
			selection_strategy = "closest",
			file_ignore_pattersn = { "node_modules", "vendor", "site-packages" },
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
				},
			},
			layout_config = {
				prompt_position = "top",
				horizontal = { mirror = false, preview_width = 0.5 },
			}
		}
	})

	require("telescope").load_extension("fzf")
end

function config.nvim_cmp()
	local cmp = require("cmp")

	local lspkind = require("lspkind")

	local sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "treesitter", keyword_length = 2 },
		{ name = "emoji" },
		{ name = "buffer" },
		{ name = "path" },
	}

	if vim.o.ft == "markdown" or vim.o.ft == "txt" or vim.o.ft == "html" or vim.o.ft == "gitcommit" then
		table.insert(sources, { name = "spell" })
		table.insert(sources, { name = "look" })
	end

	if vim.o.ft == "lua" then
		table.insert(sources, { name = "nvim_lua" })
	end

	if vim.o.ft == "zsh" or vim.o.ft == "sh" or vim.o.ft == "fish" or vim.o.ft == "proto" then
		table.insert(sources, { name = "buffer", keyword_length = 3 })
		table.insert(sources, { name = "calc" })
	end

	vim.api.nvim_set_hl(0, "transparentBG", { bg = "NONE", fg = "LightGray" })

	cmp.setup({
		require("luasnip.loaders.from_vscode").lazy_load(),

		preselect = cmp.PreselectMode.Item,

		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		completion = {
			autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
			completeopt = "menu,menuone,preview",
		},

		formatting = {
			format = lspkind.cmp_format({
				maxwidth = 50,
				ellipsis_char = "..."
			})
		},

		mapping = cmp.mapping({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(4),
			["<C-f>"] = cmp.mapping.scroll_docs(-4),
			["<C-space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<Tab>"] = cmp.mapping.confirm({ select = false }),
		}),

		experimental = {
			ghost_text = true,
		},

		sources = sources,
	})

	require("utils.helper").loader("nvim-autopairs")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { text = "" } }))

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),

		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline_history" },
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
			{ name = "cmdline_history" },
		},
	})
end

function config.mason()
	local ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "tailwindcss", "emmet_ls", "pyright", "bashls" }

	require("mason").setup({
		PATH = "skip",
		ui = {
			icons = {
				package_pending = "➢",
				package_installed = "✔",
				package_uninstalled = "✘",
			}
		},

		max_concurrent_installers = 10,
	})

	require("mason-lspconfig").setup({
		ensure_installed = ensure_installed,
		automatic_installation = true,
	})

end

return config
