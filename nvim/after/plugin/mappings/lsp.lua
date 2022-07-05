local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap


nnoremap("gd", function() vim.lsp.buf.definition() end)
nnoremap("gc", function() vim.lsp.buf.declaration() end)
nnoremap("gt", function() vim.lsp.buf.type_definition() end)
nnoremap("gr", function() require("dvd.telescope").lsp_references() end)
nnoremap("gi", function() require("dvd.telescope").lsp_implementations() end)

nnoremap("<leader>s", function() vim.lsp.buf.signature_help() end)
nnoremap("<leader>h", function() vim.lsp.buf.hover() end)

nnoremap("ca", function() vim.lsp.buf.code_action() end)
nnoremap("cd", function() require("dvd.telescope").lsp_diagnostics() end)
nnoremap("cf", function() vim.lsp.buf.formatting() end)
nnoremap("cr", function() vim.lsp.buf.rename() end)
