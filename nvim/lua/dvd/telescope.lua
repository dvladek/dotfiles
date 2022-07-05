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
        prompt_prefix = "❯ ",
        selection_cared = "❯ ",

        layout_strategy = "flex",

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

        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        color_devicons = true,

        file_sorter = require("telescope.sorters").get_fzy_sorter,

        file_previewer   = previewers.vim_buffer_cat.new,
        grep_previewer   = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },

    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            -- even more opts
            }
        }
    }
}

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("git_worktree")

local M = {}

function M.project_browser()
    local opts = themes.get_ivy {
        previewer = false,
        hidden = false,
        sorting_strategy = "ascending",
        scroll_strategy = "cycle"
    }

    require("telescope").extensions.file_browser.file_browser(opts)
end

function M.git_files()
    local path = vim.fn.expand "%:h"

    if path == "" then
        path = nil
    end

    local opts = themes.get_dropdown {
        winblend = 5,
        previewer = false,
        shorten_path = false,

        cwd = path,

        layout_config = {
            width = 0.75,
        },
    }

    require("telescope.builtin").git_files(opts)
end

function M.buffers()
    require("telescope.builtin").buffers()
end

function M.quick_search()
    local opts = themes.get_dropdown {
        winblend = 5,
        border = true,
        previewer = false,
        path_display = false,

        layout_config = {
            width = 0.75,
        },
    }

    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end


function M.git_branches()
    require"telescope.builtin".git_branches({
        attach_mappings = function(_, map)
            map("i", "<C-d>", actions.git_delete_branch)
            map("n", "CC-d>", actions.git_delete_branch)

            return true
        end
    })
end



function M.lsp_references()
    require("telescope.builtin").lsp_references {
        layout_strategy = "vertical",

        layout_config = {
            prompt_position = "top",
        },

        sorting_strategy = "ascending",
        ignore_filename = false,
    }
end

function M.lsp_implementations()
    require("telescope.builtin").lsp_implementations {
        layout_strategy = "vertical",

        layout_config = {
            prompt_position = "top",
        },

        sorting_strategy = "ascending",
        ignore_filename = false,
    }
end

function M.lsp_diagnostics()
    local opts = themes.get_dropdown {
        winblend = 5,
        border = true,

        layout_config = {
            prompt_position = "top",
            width = 0.75,
        },
    }

    require("telescope.builtin").diagnostics(opts)
end








return M
