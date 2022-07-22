local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

-- search in project
nnoremap("<C-p>", function()
    require("dvd.telescope").git_files()
end)

-- search in project (with preview)
nnoremap("<C-o>", function()
    require("telescope.builtin").git_files()
end)

-- search in filesystem
nnoremap("<C-l>", function()
    require("dvd.telescope").project_browser()
end)

-- search for buffers
nnoremap("<leader>pb", function()
    require("dvd.telescope").buffers()
end)

-- search quick and easy in current buffer only
nnoremap("<leader>qs", function()
    require("dvd.telescope").quick_search()
end)

nnoremap("<leader>gb", function()
    require("dvd.telescope").git_branches()
end)

nnoremap("<leader>gwl", function()
    require('telescope').extensions.git_worktree.git_worktrees()
end)

nnoremap("<leader>gwk", function()
    require('telescope').extensions.git_worktree.create_git_worktree()
end)

nnoremap("<leader>vc", function()
    require("telescope.builtin").colorscheme()
end)

nnoremap("<leader>vh", function()
    require("telescope.builtin").help_tags()
end)
