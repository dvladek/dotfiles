local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

local silent = { silent = true }

nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<leader>l", function() require("harpoon.ui").toggle_quick_menu() end, silent)

nnoremap("<space>q", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<space>w", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<space>e", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<space>r", function() require("harpoon.ui").nav_file(4) end, silent)
