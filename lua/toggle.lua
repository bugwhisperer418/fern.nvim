-- Toggle entry function
function toggle_entry_status()
	-- Get the current line number
	local line_num = vim.api.nvim_win_get_cursor(0)[1]
	-- Get current line content
	local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
	if not line then
		return
	end

	-- Extract marker (● ✔ ✖), ignoring indentation and known prefixes
	-- We need to find which marker (if any) is present and its position
	local found_marker, marker_start, marker_end
	for _, marker in pairs({ "●", "✔", "✖" }) do
		local start_pos = line:find(marker, 1, true)
		if start_pos then
			found_marker = marker
			marker_start = start_pos
			marker_end = start_pos + #marker - 1
			break
		end
	end

	-- Get new marker based on the toggle cycle
	local new_marker
	if found_marker == "●" then
		new_marker = "✔"
	elseif found_marker == "✔" then
		new_marker = "✖"
	elseif found_marker == "✖" then
		new_marker = "●"
	else
		vim.api.nvim_echo({ { "No toggleable entry under cursor", "WarningMsg" } }, false, {})
		return
	end

	-- Extract prefix and suffix
	local pre = line:sub(1, marker_start - 1)
	local rest = line:sub(marker_end + 1)

	-- Reconstruct the line
	local new_line = pre .. new_marker .. rest
	vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
end
