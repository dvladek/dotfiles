if not pcall(require, 'telescope') then
  return
end

local should_reload = true
local reloader = function()
    if should_reload then
        RELOAD('plenary')
        RELOAD('popup')
        RELOAD('telescope')
    end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

require('telescope').setup {
    defaults = {
        prompt_prefix = ' >',

        winblend = 0,
        preview_cutoff = 120,

        layout_strategy = 'horizontal',
        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        prompt_position = "bottom",
        color_devicons = true,

        file_sorter = sorters.get_fzy_sorter,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        file_ignore_patterns = { '.cache/*' },

        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },

            fzf_writer = {
                use_highlighter = false,
                minimum_grep_characters = 4,
            }
        },

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-s>"] = actions.select_vertical,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    }
}

pcall(require('telescope').load_extension, 'fzy_native')
pcall(require('telescope').load_extension, 'gh')

local M = {}

function M.file_browser()
    require('telescope.builtin').file_browser {
        sorting_strategy = "ascending",
    }
end


function M.grep_search()
    require('telescope.builtin').grep_string {
        shorten_path = true,
        search = vim.fn.input("Grep String > "),
    }
end


function M.live_grep()
    require('telescope').extensions.fzf_writer.staged_grep {
        shorten_path = true,
        previewer = false,
        fzf_separator = "|>",
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
        shorten_path = false,

    -- layout_strategy = 'current_buffer',
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
        cwd = "$HOME/Development/code/dvladek/dotfiles/",
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
        previewer = false,
        shorten_path = false,
    }

    require('telescope.builtin').lsp_code_actions(opts)
end


function M.lsp_document_diagnostics()
    local opts = themes.get_dropdown {
        border = true,
    }

    require('telescope.builtin').lsp_document_diagnostics(opts)
end


function M.fd()
  require('telescope.builtin').fd()
end




return M
