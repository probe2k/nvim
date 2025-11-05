local config = {}

function config.autopairs()
	local has_autopairs, _ = pcall(require, "nvim-autopairs")
	if not has_autopairs then
		print("autopairs not loaded")

		local loader = require("utils.helper").loader
		loader("nvim-autopairs")
		has_autopairs, _ = pcall(require, "nvim-autopairs")
		if not has_autopairs then
			print("autopairs not installed")
			return
		end
	end

	local npairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")
	npairs.setup({
		disable_filetype = { "TelescopePrompt" },
		autopairs = { enable = true },
		ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
		enable_check_bracket_line = false,
		html_break_line_filetype = {
			"html",
			"vue",
			"typescriptreact",
			"svelte",
			"javascriptreact",
		},
		check_ts = true,
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
			java = false,
		},
	})

	local ts_conds = require("nvim-autopairs.ts-conds")
	npairs.add_rules({
		Rule(" ", " "):with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({ "()", "[]", "{}" }, pair)
		end),
		Rule("(", ")"):with_pair(function(opts)
			return opts.prev_char:match(".%)") ~= nil
		end):use_key(")"),
		Rule("{", "}"):with_pair(function(opts)
			return opts.prev_char:match(".%}") ~= nil
		end):use_key("}"),
		Rule("[", "]"):with_pair(function(opts)
			return opts.prev_char:match(".%]") ~= nil
		end):use_key("]"),
		Rule("%", "%", "lua") -- press % => %% is only inside comment or string
		:with_pair(ts_conds.is_ts_node({ "string", "comment" })),
		Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
	})
end

function config.nvim_tree_setup()
	vim.cmd([[ autocmd Filetype NvimTree set cursorline | set statuscolumn= ]])
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "=", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))

	vim.api.nvim_set_hl(0, "NvimTreeGitNew",      { bg = "#203d27", fg = "#a6e3a1", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitDirty",    { bg = "#1d3452", fg = "#89b4fa", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitDeleted",  { bg = "#4b1e1e", fg = "#f38ba8", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitRenamed",  { bg = "#3a2d56", fg = "#cba6f7", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitStaged",   { bg = "#203d27", fg = "#94e2d5", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitMerge",    { bg = "#3a2d56", fg = "#fab387", blend = 10 })
	vim.api.nvim_set_hl(0, "NvimTreeGitIgnored",  { bg = "NONE", fg = "#585b70" })
end

function config.nvim_tree()
	require("nvim-tree").setup({
		sort_by = "case_sensitive",
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true,
		update_cwd = true,
		on_attach = on_attach,
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		view = {
			adaptive_size = false,
			side = "right",
			width = 30,
		},
		git = {
			enable = true,
			ignore = false,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = false,
			},
		},
		renderer = {
			highlight_git = true,
			group_empty = true,
			highlight_opened_files = "none",

			indent_markers = {
				enable = true,
			},

			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = false,
				},
				glyphs = {
					default = "󰈚",
					symlink = "",
					folder = {
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
						arrow_open = "",
						arrow_closed = "",
					}
				}
			},
		},
		filters = {
			dotfiles = false,
		},
	})
end

return config
