-- Module defenition ======================================
local SessionManager = {}
local H = {}

SessionManager.config = {
	mappings = {
		echo = "<leader>tt",
	},
}

H.default_config = vim.deepcopy(SessionManager.config)

SessionManager.setup = function(config)
	-- Export module
	_G.SessionManager = SessionManager

	-- Setup config
	config = H.setup_config(config)

	-- Aplly config
	H.apply_config(config)
end

H.setup_config = function(config)
	config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})
	vim.notify([[Setting up config]])
	return config
end

H.apply_config = function(config)
	vim.notify([[Applying config]])
	H.map("n", config.mappings.echo, "<Cmd>!git status<CR>", { desc = "echo 1" })
end

H.map = function(mode, lhs, rhs, opts)
	if lhs == "" then
		return
	end
	opts = vim.tbl_deep_extend("force", { silent = true }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

return SessionManager
