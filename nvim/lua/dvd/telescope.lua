local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_mt = require("telescope.actions.mt")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

require("telescope").setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_cared = '❯ ',

        layout_strategy = 'flex',

        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
                width = { padding = 0.1 },
            },

            vertical = {
                preview_height = 0.75,
            },

        },

        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        scroll_strategy = 'cycle',
        color_devicons = true,

        file_sorter = require("telescope.sorters").get_fzy_sorter,

        file_previewer   = previewers.vim_buffer_cat.new,
        grep_previewer   = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    }
}

require("telescope").load_extension("git_worktree")

local M = {}

function M.grep_search()
    require('telescope.builtin').grep_string {
        path_display = "shorten",
        search = vim.fn.input("Grep String > "),
    }
end

function M.buffers()
    require('telescope.builtin').buffers()
end


function M.quick_search()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        path_display = false,
    }

    require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.git_branches()
    require'telescope.builtin'.git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)

            return true
        end
    })
end


return M


