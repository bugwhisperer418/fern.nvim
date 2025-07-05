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
  (feel) @type
  ;; Special markers
  (emphasis) @error
  (question) @info
  ;; Entries with emphasis marker (should be very visible)
  (entry 
    mark: (emphasis)) @error
]]

-- Define highlight groups
function setup_highlights()
	-- Header highlights
	vim.api.nvim_set_hl(0, "@keyword.fernlog", { link = "Keyword" })
	vim.api.nvim_set_hl(0, "@title.fernlog", { link = "Title" })
	-- Entry type markers
	vim.api.nvim_set_hl(0, "@punctuation.special.fernlog", { fg = "#3cb371", bold = true }) -- ToDo
	vim.api.nvim_set_hl(0, "@info.fernlog", { fg = "#daa520", bold = true }) -- Question
	vim.api.nvim_set_hl(0, "@type.fernlog", { fg = "#87cefa", bold = true }) -- Feel
	-- Extra Red background highlight for Emphasis markers to call it out
	vim.api.nvim_set_hl(0, "@error.fernlog", {
		bg = "#ffebe9",
		fg = "#d1242f",
	})
end
