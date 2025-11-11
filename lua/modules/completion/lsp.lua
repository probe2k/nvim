local M = {}

local keymap = vim.keymap

local on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
	keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
	keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = "⛔️",
			[severity.WARN] = "❗️",
			[severity.INFO] = "💡",
			[severity.HINT] = "⚡️",
		},
		texthl = {
			[severity.ERROR] = "DiagnosticSignError",
			[severity.WARN] = "DiagnosticSignWarn",
			[severity.INFO] = "DiagnosticSignInfo",
			[severity.HINT] = "DiagnosticSignHint",
		},
		numhl = {
			[severity.ERROR] = "DiagnosticSignError",
			[severity.WARN] = "DiagnosticSignWarn",
			[severity.INFO] = "DiagnosticSignInfo",
			[severity.HINT] = "DiagnosticSignHint",
		},
		linehl = {
			[severity.ERROR] = "DiagnosticSignError",
			[severity.WARN] = "DiagnosticSignWarn",
			[severity.INFO] = "DiagnosticSignInfo",
			[severity.HINT] = "DiagnosticSignHint",
		},
	},
	update_in_insert = true,
	virtual_text = { prefix = " " },
})

vim.lsp.config("html", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("emmet_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("bashls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("cssls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "svelte", "less" }
})

vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 10000,
				preloadFileSize = 10000,
			},
		}
	}
})

vim.lsp.enable("html")
vim.lsp.enable("ts_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("pyright")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("lua_ls")

return M
