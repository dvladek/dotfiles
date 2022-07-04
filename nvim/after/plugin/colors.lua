vim.g.dvd_colorscheme = "base16-tomorrow-night"
-- vim.g.dvd_colorscheme = "nord"

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
