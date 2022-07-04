local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-c>", function() vim.lsp.buf.code_action() end)
