local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local themes = require('telescope.themes')

require('telescope').load_extension('file_browser')

local M = {}

function M.project_browser()
  local opts = themes.get_ivy {
    previewer = false,
    hidden = false
  }

  require("telescope").extensions.file_browser.file_browser(opts)
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").git_files(opts)
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

function M.lsp_definitions()
  local opts = themes.get_dropdown {
    winblend = 5,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").lsp_definitions(opts)
end

function M.lsp_references()
  local opts = themes.get_dropdown {
    winblend = 5,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").lsp_references(opts)
end

function M.lsp_type_definitions()
  local opts = themes.get_dropdown {
    winblend = 5,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").lsp_type_definitions(opts)
end

function M.lsp_implementations()
  local opts = themes.get_dropdown {
    winblend = 5,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").lsp_implementations(opts)
end

function M.lsp_diagnostics()
  local opts = themes.get_dropdown {
    winblend = 5,

    layout_config = {
      width = 0.75,
    },
  }

  require("telescope.builtin").diagnostics(opts)
end

function M.build_sh()
  local build = require('config.build')
  local root = build.project_root()

  if vim.fn.filereadable(root .. '/build.sh') == 0 then
    vim.notify('No build.sh found at: ' .. (root .. '/build.sh'), vim.log.levels.WARN)
    return
  end

  local entries = {
    { label = 'Build (dev)  ./build.sh dev', mode = 'dev' },
    { label = 'Build (rel)  ./build.sh rel', mode = 'rel' },
  }

  local opts = themes.get_dropdown {
    winblend = 5,
    border = true,
    previewer = false,
    path_display = false,

    layout_config = {
      width = 0.75,
    },
  }

  pickers.new(opts, {
    prompt_title = 'build.sh',

    finder = finders.new_table({
      results = entries,
      entry_maker = function(e)
        return {
          value = e,
          display = e.label,
          ordinal = e.label
        }
      end,
    }),

    sorter = conf.values.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local function run_selected()
        local selection = action_state.get_selected_entry().value
        actions.close(prompt_bufnr)
        build.run(selection.mode)
      end

      map('i', '<CR>', run_selected)
      map('n', '<CR>', run_selected)

      return true
    end,
  }):find()
end

return M
