if not pcall(require, 'telescope') then
  return
end

local should_reload = true
local reloader = function()
    if should_reload then
        RELOAD 'plenary'
        RELOAD 'popup'
        RELOAD 'telescope'
    end
end

reloader()

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local action_mt = require 'telescope.actions.mt'
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local previewers = require 'telescope.previewers'
local sorters = require 'telescope.sorters'
local themes = require 'telescope.themes'

local _ = pcall(require, 'nvim-nonicons')

require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_cared = '❯ ',

        winblend = 0,

        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = 'bottom',

            horizontal = {
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },

            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                horizontal = {
                    preview_width = 0.9,
                },
            },
        },

        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        scroll_strategy = 'cycle',
        color_devicons = true,

        file_previewer   = previewers.vim_buffer_cat.new,
        grep_previewer   = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            },

            fzf_writer = {
                use_highlighter = false,
                minimum_grep_characters = 6,
            }
        },
    }
}

pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "notify")
pcall(require('telescope').load_extension, 'fzf')

if vim.fn.executable 'gh' == 1 then
    pcall(require('telescope').load_extension, 'gh')
    pcall(require('telescope').load_extension, 'octo')
end

pcall(require('telescope').load_extension, 'git_worktree')


local M = {}

function M.file_browser()
    require('telescope.builtin').file_browser {
        sorting_strategy = "ascending",
    }
end


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


function M.edit_dotfiles()
    require('telescope.builtin').find_files {
        prompt_title = "< VimRC >",
        cwd = "$DOTS/",
    }
end


function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end


function M.lsp_code_actions()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
    }

    require('telescope.builtin').lsp_code_actions(opts)
end


function M.lsp_document_diagnostics()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
    }

    require('telescope.builtin').lsp_document_diagnostics(opts)
end


function M.worktree_list()
    require('telescope').extensions.git_worktree.git_worktrees()
end


function M.worktree_create()
    require('telescope').extensions.git_worktree.create_git_worktree()
end

return M
