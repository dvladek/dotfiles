if not pcall(require, 'telescope') then
  return
end

local sorters = require('telescope.sorters')

TelescopeMapArgs = TelescopeMapArgs or {}

local telescope_mapper = function(key, context, f, options)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    local mode = 'n'
    TelescopeMapArgs[map_key] = options or {}

    local rhs = string.format(
        "<cmd> lua R('%s')['%s'](TelescopeMapArgs['%s'])<CR>",
        context,
        f,
        map_key
    )

    local map_options = {
        noremap = true,
        silent = true,
    }

    vim.api.nvim_set_keymap(
        mode,
        key,
        rhs,
        map_options)
end

telescope_mapper('<C-p>', 'telescope.builtin', 'git_files')
telescope_mapper('<C-l>', 'telescope.builtin', 'file_browser')

telescope_mapper('<leader>ps', 'dvd.telescope', 'grep_search')
telescope_mapper('<leader>pb', 'dvd.telescope', 'buffers')
telescope_mapper('<leader>qs', 'dvd.telescope', 'quick_search')

telescope_mapper('<leader>gb', 'dvd.telescope', 'git_branches')
telescope_mapper('<leader>gwl', 'dvd.telescope', 'worktree_list')
telescope_mapper('<leader>gwc', 'dvd.telescope', 'worktree_create')

telescope_mapper('<leader>ed', 'dvd.telescope', 'edit_dotfiles')

telescope_mapper('<leader>a', 'dvd.telescope', 'lsp_code_actions')
telescope_mapper('<leader>s', 'dvd.telescope', 'lsp_document_diagnostics')

telescope_mapper('<leader>vh', 'dvd.telescope', 'help_tags')
telescope_mapper('<leader>vw', 'telescope.builtin', 'symbols')

return telescope_mapper
