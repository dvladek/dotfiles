local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>gs", function() require("neogit").open({ kind = "split_above" }) end)
