local config = {}

math.randomseed(os.time())

function config.noice()
	require("noice").setup({
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = "󰛪 ", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
				input = { view = "cmdline_input", icon = " " },
			}
		},

		messages = { enabled = true },

		popupmenu = { enabled = true },

		lsp = {
			progress = { enabled = true },
			hover = { enabled = false },
			signature = { enabled = true },
		}
	})
end

function config.starry()
	require("transparent").setup({
		groups = {
			"Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
			"Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
			"Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
			"SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
			"EndOfBuffer", "FloatBorder",
		},
		extra_groups = {
			"NormalFloat", "TelescopeNormal", "TelescopePromptBorder", "TelescopePreviewBorder", "TelescopeResultsBorder", "NvimTreeNormal", "ColorColumn"
		},
		exclude_groups = {},
		on_clear = function() end,
	})

	require("starry").setup({
		border = false,
		italics = {
			comments = true,
			keywords = false,
			functions = true,
			variables = false,
			strings = false,
		},
		contrast = { enable = true, terminal = true },
		disable = { background = true, term_colors = false },
		style = { name = "earlysummer" },
	})

	vim.cmd([[ TransparentEnable ]])
	vim.cmd([[ colorscheme moonlight ]])
end

function config.lualine()
	require("lualine").setup({
		options = {
			theme = {
				normal = {
					a = { fg = "#b4dce7", gui = "bold" },
					b = { fg = "#b4dce7" },
					c = { fg = "#b4dce7" }
				},
				insert = {
					a = { fg = "#c9e4b8", gui = "bold" },
					b = { fg = "#b4dce7" },
					c = { fg = "#b4dce7" }
				},
				visual = {
					a = { fg = "#e8d2b4", gui = "bold" },
					b = { fg = "#b4dce7" },
					c = { fg = "#b4dce7" }
				},
				replace = {
					a = { fg = "#e8b4b4", gui = "bold" },
					b = { fg = "#b4dce7" },
					c = { fg = "#b4dce7" }
				},
				command = {
					a = { fg = "#d4b4e8", gui = "bold" },
					b = { fg = "#b4dce7" },
					c = { fg = "#b4dce7" }
				},
				inactive = {
					a = { fg = "#a0a0a0", gui = "bold" },
					b = { fg = "#a0a0a0" },
					c = { fg = "#a0a0a0" }
				}
			},
--			component_separators = {left = "│", right = "│"},
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			refresh = {
				statusline = 1000,
			}
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						local mode_map = {
							n = "NORMAL",
							i = "INSERT",
							v = "VISUAL",
							V = "V-LINE",
							[""] = "V-BLOCK",
							c = "COMMAND",
							s = "SELECT",
							S = "S-LINE",
							[""] = "S-BLOCK",
							t = "TERMINAL"
						}
						return mode_map[str] or str
					end,
					color = { fg = "#c9e4b8" }
				}
			},
			lualine_b = {
				{
					"filename",
					color = { fg = "#e8d2b4" },
					symbols = { modified = "  ", readonly = "  ", unnamed = "  " }
				}
			},
			lualine_c = {
				{
					"filetype",
					colored = true,
					icon_only = true,
					color = { fg = "#ffffff" }
				},
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						unix = " ",
						dos = " ",
						mac = " "
					},
					color = { fg = "#b4dce7" }
				}
			},
			lualine_x = {
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " "
					},
					color_added = "#c9e4b8",
					color_modified = "#e8d2b4",
					color_removed = "#e8b4b4"
				}
			},
			lualine_y = {
				{
					"progress",
					color = { fg = "#e8d2b4" }
				}
			}
		},
		inactive_sections = {
			lualine_a = {
				{
					"filename",
					color = { fg = "#a0a0a0" },
					symbols = { modified = "  ", readonly = "  " }
				}
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{
					"filetype",
					color = { fg = "#a0a0a0" }
				}
			}
		},
--		tabline = {
--			lualine_a = {
--				{
--					"tabs",
--					mode = 2,
--					tabs_color = {
--						active = {fg = "none", bg = "#e8b4b4"},
--						inactive = {fg = "#b4dce7", bg = "none"}
--					},
--					fmt = function(name, context)
--						return string.format(" %s:%s ", context.tabnr, name)
--					end
--				}
--			}
--		},
--		extensions = {"fugitive", "nvim-tree", "toggleterm"}
	})
end

return config
