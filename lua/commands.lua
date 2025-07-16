local cmds = {
	{ name = "Toggle", action = toggle_entry_status }, -- Toggle Task status
}

function setup_user_commands()
	for _, c in pairs(cmds) do
		vim.api.nvim_buf_create_user_command(
			0, -- cmd always targets current buffer
			"Fern" .. c.name, -- cmd name
			c.action, -- cmd string or Lua function
			c.attrb or {} -- cmd attributes table
		)
	end
end
