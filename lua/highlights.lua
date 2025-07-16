-- Tree-sitter highlights queries
-- used for manual setup in M.setup()
highlights_query = [[
  ; Header markers
  (h1_marker) @keyword
  (h2_marker) @keyword
  (h3_marker) @keyword
  (h4_marker) @keyword
  (h5_marker) @keyword
  (h6_marker) @keyword
  ;; Header content
  (header_content) @title
  ;; Entry type markers - use different colors for different types
  (todo) @punctuation.special
  (done) @argument
  (cancelled) @function
  (feel) @type
  ;; Special markers
  (emphasis) @error
  (question) @info
  ;; Entries with emphasis marker (should be very visible)
  (entry 
    mark: (emphasis)) @error
]]

-- Define highlight groups
function setup_highlights(user_colors)
	-- Default colors for entries and markers
	local colors = vim.tbl_deep_extend("force", {
		header = { fg = "#575075" },
		todo = { fg = "#3cb371" },
		done = { fg = "#466853" },
		cancelled = { fg = "#98776a" },
		question = { fg = "#daa520" },
		feel = { fg = "#87cefa" },
		emphasis = { fg = "#d1242f", bg = "#ffebe9" },
	}, user_colors)
	-- Header highlights
	vim.api.nvim_set_hl(0, "@keyword.fernlog", { link = "Keyword", fg = colors.header.fg })
	vim.api.nvim_set_hl(0, "@title.fernlog", { link = "Title", fg = colors.header.fg })
	-- Entry type markers
	vim.api.nvim_set_hl(0, "@punctuation.special.fernlog", { fg = colors.todo.fg, bold = true }) -- ToDo Task
	vim.api.nvim_set_hl(0, "@argument", { fg = colors.done.fg, bold = true }) -- Done Task
	vim.api.nvim_set_hl(0, "@function", { fg = colors.cancelled.fg, bold = true }) -- Cancelled Task
	vim.api.nvim_set_hl(0, "@info.fernlog", { fg = colors.question.fg, bold = true }) -- Question marker
	vim.api.nvim_set_hl(0, "@type.fernlog", { fg = colors.feel.fg, bold = true }) -- Feel marker
	-- Extra Red background highlight for Emphasis markers to call it out
	vim.api.nvim_set_hl(0, "@error.fernlog", {
		bg = colors.emphasis.bg,
		fg = colors.emphasis.fg,
	})
end
