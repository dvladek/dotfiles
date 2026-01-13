return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      -- 'polarmutex/git-worktree.nvim',
    },

    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        },
        defaults = {
          layout_strategy = 'flex',

          layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
              width = {
                padding = 0.1
              }
            },

            vertical = {
              preview_height = 0.75,
            },
          }
        }
      }

      require('telescope').load_extension('fzf')
      -- require('telescope').load_extension('git_worktree')

      local builtin = require('telescope.builtin')
      local personal = require('config.telescope.pickers')
      -- local extensions = require('telescope.extensions')

      vim.keymap.set('n', '<C-p>', personal.project_browser, { desc = '[P]roject directory' })
      vim.keymap.set('n', '<C-l>', personal.git_files, { desc = '[List] files' })
      vim.keymap.set('n', '<C-å>', builtin.git_files, { desc = '[List] files with det[Å]ils' })

      vim.keymap.set('n', '<leader>en', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[List] files in [EN]vironment' })


      vim.keymap.set('n', '<space>pb', builtin.buffers, { desc = '[List] [P]roject [B]uffers' })
      vim.keymap.set('n', '<space>gb', builtin.git_branches, { desc = '[List] [G]it [B]ranches' })
      -- vim.keymap.set('n', '<space>gw', extensions.git_worktree.git_worktrees, { desc = 'workspaces' })

      vim.keymap.set('n', '<leader>w', personal.quick_search, { desc = '[W]alk and find (in file)' })
      vim.keymap.set('n', '<leader>s', builtin.grep_string, { desc = '[S]earch (in project)' })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[H]elp' })

      vim.keymap.set('n', '<leader>b', personal.build_sh, { desc = '[B]uild (build.sh)' })
    end
  }
}
