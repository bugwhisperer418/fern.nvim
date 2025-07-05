require("folding")
require("highlights")
require("toggle")

local M = {}

M.setup = function()
	-- Setup Fern rapid entry abbreviations
	local entries = {
		ee = "○", -- event
		ef = "❤", -- feel
		et = "●", -- todo
	}
	for typo, correct in pairs(entries) do
		vim.cmd("abbr " .. typo .. " " .. correct)
	end

	-- Default configuration
	local config = vim.tbl_deep_extend("force", {
		filetype = "fernlog",
		file_extensions = { "log" }, -- Only load for these filetypes
		use_colorscheme_colors = true,
		highlight_groups = {},
	}, {})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.fernlog = {
		install_info = {
			url = vim.fn.expand("~/Projects/SH/tree-sitter-fernlog"), -- local path or git repo
			files = { "src/parser.c" },
			-- optional entries:
			branch = "main", -- default branch in case of git repo if different from master
			generate_requires_npm = false, -- if stand-alone parser without npm dependencies
			requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
		},
	}

	-- Register target file extensions with the custom filetype
	for _, ext in pairs(config.file_extensions) do
		vim.filetype.add({
			extension = {
				[ext] = "fernlog",
			},
		})
	end

	-- Set up autocmds for the filetype
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "fernlog",
		callback = function()
			-- Enable treesitter highlighting for this buffer
			vim.treesitter.start(0, "fernlog")
			-- Use custom fold expression
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.fernlog_fold_expr(v:lnum)"
			-- Set fold options
			vim.opt_local.foldlevel = 2
			vim.opt_local.foldenable = true
			vim.opt_local.foldnestmax = 6
			-- Optional: Set custom fold text
			vim.opt_local.foldtext = "v:lua.fernlog_fold_text()"
			-- Set up specific keymaps for this filetype
			vim.keymap.set("n", "<leader>b", toggle_entry_status, { desc = "Toggle status (●|✔|✖)" })
			vim.keymap.set("n", "<TAB>", "za", { desc = "Toggle fold" })
		end,
	})

	-- Set up highlights
	setup_highlights()
	vim.api.nvim_create_augroup("FernlogHighlights", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = "FernlogHighlights",
		callback = function()
			setup_highlights()
		end,
	})
	-- Manual setup of queries here avoids user needing to
	-- link/copy TS highlights file to their config dir
	-- TODO: Check if there is a better way to do this
	vim.treesitter.query.set("fernlog", "highlights", highlights_query)
end

return M
