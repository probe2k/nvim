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
			"NormalFloat", "TelescopeNormal", "TelescopePromptBorder", "TelescopePreviewBorder", "TelescopeResultsBorder", "NvimTreeNormal", "ColorColumn", "WinBar", "WinBarNC"
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
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				},
				insert = {
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				},
				visual = {
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				},
				replace = {
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				},
				command = {
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				},
				inactive = {
					a = { bg = "none", gui = "bold" },
					b = { bg = "none", gui = "bold" },
					c = { bg = "none", gui = "bold" },
				}
			},
			--   component_separators = {left = "│", right = "│"},
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true
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
					color = { fg = "#3fcc7d" }
				}
			},
			lualine_b = {
				{
					"filename",
					color = { fg = "#df8f3f" },
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
					function()
						return "%="
					end
				},
				{
					function()
						local msg = "Inactive"
						local buf_ft = vim.api.nvim_get_option_value("filetype", {})
						local clients = vim.lsp.get_clients { bufnr = 0 }
						if next(clients) == nil then
							return msg
						end

						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
						end
					end,
					icon = "  LSP:"
				}
			},
			lualine_x = {
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						unix = " ",
						dos = " ",
						mac = " "
					},
					color = { fg = "#9f2f50" }
				},
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
		}
	})
end

return config
