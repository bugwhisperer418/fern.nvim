-- Tree-sitter highlights queries
-- used for manual setup in M.setup()
highlights_query = [[
  ; Header markers
  (h1) @text.title.1
  (h2) @text.title.2
  (h3) @text.title.3
  (h4) @text.title.4
  (h5) @text.title.5
  (h6) @text.title.6
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
  ;; Inline content highlighting
  (tag) @tag
  (code) @string.special
  ;; Link highlighting
  (link_markdown) @markup.link
  (link_wiki) @markup.link
]]

-- Define highlight groups
function setup_highlights(user_colors)
	-- Default colors for entries and markers
	local colors = vim.tbl_deep_extend("force", {
		h1 = { fg = "#c4a7e7", bg = "#56526e" },
		h2 = { fg = "#9ccfd8" },
		h3 = { fg = "#ea9a97" },
		h4 = { fg = "#f6c177" },
		h5 = { fg = "#f6c177" },
		h6 = { fg = "#f6c177" },
		todo = { fg = "#95b1ac" },
		done = { fg = "#6e6a86" },
		cancelled = { fg = "#6e6a86" },
		question = { fg = "#daa520" },
		feel = { fg = "#87cefa" },
		emphasis = { fg = "#eb6f92", bg = "#56526e" },
		tag = { fg = "#908caa", bg = "#44415a" },
		inline_code = { fg = "#95b1ac", bg = "#44415a" },
		link = { fg = "#8be9fd" },
	}, user_colors)
	-- Header highlights
	vim.api.nvim_set_hl(0, "@text.title.1.fernlog", { fg = colors.h1.fg, bg = colors.h1.bg, bold = true })
	vim.api.nvim_set_hl(0, "@text.title.2.fernlog", { fg = colors.h2.fg, bold = true })
	vim.api.nvim_set_hl(0, "@text.title.3.fernlog", { fg = colors.h3.fg, bold = true })
	vim.api.nvim_set_hl(0, "@text.title.4.fernlog", { fg = colors.h4.fg, bold = true })
	vim.api.nvim_set_hl(0, "@text.title.5.fernlog", { fg = colors.h5.fg, bold = true })
	vim.api.nvim_set_hl(0, "@text.title.6.fernlog", { fg = colors.h6.fg, bold = true })
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
	-- Inline content highlights
	vim.api.nvim_set_hl(0, "@tag.fernlog", { fg = colors.tag.fg, bg = colors.tag.bg, italic = true })
	vim.api.nvim_set_hl(0, "@string.special.fernlog", {
		fg = colors.inline_code.fg,
		bg = colors.inline_code.bg,
		italic = true,
	})
	vim.api.nvim_set_hl(0, "@markup.link.fernlog", { fg = colors.link.fg, underline = true })
end
