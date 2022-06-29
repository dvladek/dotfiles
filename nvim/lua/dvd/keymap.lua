local M = {}

function bind(mode, options)
    options = options or {noremap = true}

    return function(key, rhs, map_options)
        map_options = vim.tbl_extend("force",
	        options,
	        map_options or {}
	    )

	    vim.keymap.set(mode, key, rhs, map_options)
    end

end

M.nmap = bind("n", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

return M
