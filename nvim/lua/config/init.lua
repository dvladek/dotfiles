require('config.lazy')
require('config.options')
require('config.keymaps')
require('config.build')

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
