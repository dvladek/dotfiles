local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

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



return M
