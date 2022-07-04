local augroup = vim.api.nvim_create_augroup
DVDGroup = augroup('DVD', {})

require("dvd.options")
require("dvd.packer")
require("dvd.keymap")
require("dvd.telescope")
require("dvd.lsp")
-- require("dvd.dap")
require("dvd.luasnip")

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = DVDGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
