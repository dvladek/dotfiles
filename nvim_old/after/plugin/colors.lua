-- vim.g.dvd_colorscheme = "base16-tomorrow-night"
-- vim.g.dvd_colorscheme = "nord"
-- vim.g.dvd_colorscheme = "everforest"'
vim.g.dvd_colorscheme = "nordfox"
-- vim.g.dvd_colorscheme = "base16-gruvbox-dark-hard"

function ColorVim()
    vim.cmd("colorscheme " .. vim.g.dvd_colorscheme)
    -- vim.o.background = 'dark'
    -- local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
	-- vim.api.nvim_set_hl(0, 'Comment', bools)

    local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("WinSeparator", {
        bg = "none",
    })

end

ColorVim()
