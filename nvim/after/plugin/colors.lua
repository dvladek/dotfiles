-- vim.g.dvd_colorscheme = "base16-tomorrow-night"
-- vim.g.dvd_colorscheme = "nord"
-- vim.g.dvd_colorscheme = "everforest"
vim.g.dvd_colorscheme = "nordfox"

function ColorVim()
    vim.cmd("colorscheme " .. vim.g.dvd_colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("WinSeparator", {
        bg = "none",
    })

end

ColorVim()
