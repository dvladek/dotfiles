local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- remap to something else!
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- TODO: add a terminal <C-t> key to open it on the vsplit
