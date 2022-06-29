local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", function()
    require("telescope.builtin").git_files()
end)

nnoremap("<C-l>", function()
    require("telescope.builtin").find_files()
end)

-- grep_string
-- no sure if I want this. Looks for info in the project, but in the
-- bottom line.
nnoremap("<leader>ps", function()
    require("dvd.telescope").grep_search()
end)

-- search for buffers
nnoremap("<leader>pb", function()
    require("dvd.telescope").buffers()
end)

-- current_buffer_fuzzy_find
-- search qucik and easy in current buffer only
nnoremap("<leader>qs", function()
    require("dvd.telescope").quick_search()
end)

nnoremap("<leader>gb", function()
    require("dvd.telescope").git_branches()
end)

nnoremap("<leader>gwl", function()
    require('telescope').extensions.git_worktree.git_worktrees()
end)
nnoremap("<leader>gwc", function()
    require('telescope').extensions.git_worktree.create_git_worktree()
end)

-- builtin.command_history
-- builtin.man_pages
-- builtin.colorscheme
--builtin.current_buffer_fuzzy_find
-- builtin.git_branches
-- builtin.git_commits
-- builtin.git_bcommits
-- builtin.git_status
-- builtin.git_stash
-- builtin.lsp_references
-- builtin.lsp_document_symbols
-- builtin.lsp_workspace_symbols
-- builtin.lsp_dynamic_workspace_symbols
-- builtin.diagnostics
-- builtin.lsp_implementations
-- builtin.lsp_definitions
-- builtin.lsp_type_definitions
-- builtin.help_tags
-- builtin.symbols
