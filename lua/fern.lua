require("folding")
require("highlights")
require("toggle")
require("commands")

local M = {}

M.setup = function(user_config)
	-- Extend Default configuration with user configs
	local uconf = user_config or {}
	local config = vim.tbl_deep_extend("force", {
		filetype = "fernlog",
		file_extensions = { "log" }, -- Only load for these filetypes
		use_colorscheme_colors = true,
		highlight_groups = {},
		colors = {},
		keybindings = {
			entry_toggle = "<leader>b",
			fold_toggle = "<TAB>",
		},
	}, uconf)

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.fernlog = {
		install_info = {
			url = "https://git.sr.ht/~bugwhisperer/tree-sitter-fernlog",
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
			vim.opt_local.foldlevel = config.fold_lvl or 2
			vim.opt_local.foldenable = true
			vim.opt_local.foldnestmax = 6
			-- Optional: Set custom fold text
			vim.opt_local.foldtext = "v:lua.fernlog_fold_text()"

			-- Setup Fern rapid entry annotations
			local entries = {
				ee = "○", -- event
				ef = "❤", -- feel
				et = "●", -- task
			}
			for typo, correct in pairs(entries) do
				vim.cmd("abbr " .. typo .. " " .. correct)
			end

			-- Set up Vim user commands
			setup_user_commands()

			-- Set up specific keymaps for this filetype
			vim.keymap.set(
				"n",
				config.keybindings.entry_toggle,
				toggle_entry_status,
				{ desc = "Toggle status (●|✔|✖)" }
			)
			vim.keymap.set("n", config.keybindings.fold_toggle, "za", { desc = "Toggle fold" })
		end,
	})

	-- Set up highlights
	setup_highlights(config.colors)
	vim.api.nvim_create_augroup("FernlogHighlights", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = "FernlogHighlights",
		callback = function()
			setup_highlights(config.colors)
		end,
	})
	-- Manual setup of queries here avoids user needing to
	-- link/copy TS highlights file to their config dir
	vim.treesitter.query.set("fernlog", "highlights", highlights_query)
end

return M
