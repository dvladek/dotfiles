return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
    },

    config = function()
      local dap = require('dap')
      local ui = require('dapui')

      -- UI
      ui.setup({
        icons = {
          expanded = '▾',
          collapsed = '▸',
          current_frame = '*'
        },

        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          }
        },
      })

      require('dap-go').setup()

      -- Mason DAP: install codelldb
      local mason_dap = require('mason-nvim-dap')
      mason_dap.setup({
        ensure_installed = {
          'codelldb'
        },
        automatic_installation = true,

        handlers = {
          function(config)
            mason_dap.default_setup(config)
          end,
        },
      })

      ----------------------------------------------------------------------
      -- Ensure adapter is set (hard-set to Mason path)
      -- TODO(dvladek): Check if there is a better day to do it
      ----------------------------------------------------------------------
      local codelldb = vim.fn.stdpath('data') .. '/mason/bin/codelldb'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb,
          args = {
            '--port',
            '${port}'
          },
        },
      }

      -- C/C++ launch configuration (LLDB backend)
      dap.configurations.cpp = {
        {
          name = 'Launch (codelldb)',
          type = 'codelldb',
          request = 'launch',

          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,

          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- Automatically open/close the UI
      dap.listeners.after.event_initialized['dapui_config'] = function() ui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() ui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() ui.close() end

      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = '[D]ebug [T]oggle breakpoint' })
      vim.keymap.set('n', '<leader>dr', dap.run_to_cursor, { desc = '[D]ebug [R]un to cursor' })
      vim.keymap.set('n', '<leader>du', ui.open, { desc = '[D]ebug Open [U]I' })
      vim.keymap.set('n', '<leader>dc', ui.close, { desc = '[D]ebug [C]lose UI' })

      vim.keymap.set('n', '<leader>d1', dap.continue, { desc = 'DAP: Continue/Start' })
      vim.keymap.set('n', '<leader>d2', dap.step_into, { desc = 'DAP: Step into' })
      vim.keymap.set('n', '<leader>d3', dap.step_over, { desc = 'DAP: Step over' })
      vim.keymap.set('n', '<leader>d4', dap.step_out, { desc = 'DAP: Step out' })
      vim.keymap.set('n', '<leader>d5', dap.step_back, { desc = 'DAP: Step back' })
      vim.keymap.set('n', '<leader>d6', dap.restart, { desc = 'DAP: Restart' })
    end,
  },
}
