-- Custom expression for hierarchical folding
function fernlog_fold_expr(lnum)
	local line = vim.fn.getline(lnum)
	-- Check if line is a header
	if line:match("^#[^#]") then
		return ">1"
	elseif line:match("^##[^#]") then
		return ">2"
	elseif line:match("^###[^#]") then
		return ">3"
	elseif line:match("^####[^#]") then
		return ">4"
	elseif line:match("^#####[^#]") then
		return ">5"
	elseif line:match("^######") then
		return ">6"
	else
		-- For non-header lines, maintain the current fold level
		return "="
	end
end

-- Custom fold text function
function fernlog_fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	local text = line
	if line:match("^#[#]*") then
		text = line:gsub("^#[#]*%s*", "")
	end
	-- Return fold text with indicator and line count
	return "╣ " .. text .. string.format(" (%d lines)", line_count)
end

-- Make fold functions globally accessible
-- TODO: Check if there a better way to do this
_G.fernlog_fold_expr = fernlog_fold_expr
_G.fernlog_fold_text = fernlog_fold_text
