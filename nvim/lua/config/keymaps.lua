vim.keymap.set('i', 'ı', '{')
vim.keymap.set('i', 'œ', '}')

local build = require("config.build")
vim.keymap.set('n', '<leader>bd', function() build.run('dev') end, { desc = '[B]uild (dev)' })
vim.keymap.set('n', '<leader>br', function() build.run('rel') end, { desc = '[B]uild (rel)' })
