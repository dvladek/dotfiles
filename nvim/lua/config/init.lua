require('config.lazy')
require('config.options')
require('config.keymaps')

local augroup = vim.api.nvim_create_augroup
local DVDGroup = augroup('DVD', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', { clear = true })

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ 'BufWritePre' }, {
  group = DVDGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd({ 'TermOpen' }, {
  group = DVDGroup,
  callback = function(ev)
    -- In terminal mode, 'qq' closes the terminal *window*
    vim.keymap.set('t', 'qq', [[<C-\><C-n>:close<CR>]], {
        buffer = ev.buf,
        silent = true,
        desc = 'Close terminal window'
    })
  end,
})
