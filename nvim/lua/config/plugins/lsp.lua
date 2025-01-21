return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },

      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Autoformatting
      'stevearc/conform.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',

      -- Update information
      'j-hui/fidget.nvim',
    },

    config = function()
      -- Current list of filetypes
      require('conform').setup({
        formatters_by_ft = {
        }
      })

      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require('fidget').setup({})

      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'lua_ls',
          'clangd',
          'pylsp',
          'ts_ls',
        }
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ['clangd'] = function()
          require('lspconfig').clangd.setup({
            cmd = {
              'clangd',
              '--background-index',
              '--suggest-missing-includes',
              '--clang-tidy',
              '--header-insertion=iwyu',
            },
            init_options = {
              clangdFileStatus = true
            },
            filetypes = { 'c', 'cpp', 'cxx', 'h', 'hpp', 'hxx', 'ipp', 'objc', 'objcpp' },
            capabilities = capabilities,
          })
        end,

        ['pylsp'] = function()
          require('lspconfig').pylsp.setup({
            capabilities = capabilities,
          })
        end,

        ['ts_ls'] = function()
          require('lspconfig').ts_ls.setup({
            root_dir = require('lspconfig').util.root_pattern 'package.json',
            single_file = false,
            server_capabilities = {
              documentFormattingProvider = false,
            },
            capabilities = capabilities,
          })
        end,
      })

      --[[
      vim.keymap.set("n", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, underline = false,
            float = {
              border = {
                { "╔", "FloatBorder" },
                { "═", "FloatBorder" },
                { "╗", "FloatBorder" },
                { "║", "FloatBorder" },
                { "╝", "FloatBorder" },
                { "═", "FloatBorder" },
                { "╚", "FloatBorder" },
                { "║", "FloatBorder" }
              },
              source = "always",
              update_in_insert = true,
              severity_sort = true,
            }, }
        else
          vim.diagnostic.config { virtual_text = true, underline = false, }
        end
      end, { desc = "Toggle lsp_lines" })
      --]]

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local builtin = require('telescope.builtin')
          local personal = require('config.telescope.pickers')

          vim.keymap.set('n', 'cd', personal.lsp_definitions, { desc = 'Go to [C]ode [D]efinitions' })
          vim.keymap.set('n', 'cr', personal.lsp_references, { desc = 'Go to [C]ode [R]eferences' })
          vim.keymap.set('n', 'cc', vim.lsp.buf.declaration, { desc = 'Go to [C]ode de[C]laration' })
          vim.keymap.set('n', 'ct', personal.lsp_type_definitions, { desc = 'Go to [C]ode [T]ype definitions' })
          vim.keymap.set('n', 'ci', personal.lsp_implementations, { desc = 'Go to [C]ode [I]mplementations' })

          vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = 'Show [C]ode [A]ctions' })
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = '[R]ename symbol' })
          vim.keymap.set('n', '<leader>e', builtin.lsp_document_symbols, { desc = 'Navigate [E]nvirenment' })

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show [K]ode in cursor' })
          vim.keymap.set('n', 'S', vim.lsp.buf.signature_help, { desc = 'Show [S]ignature' })
          vim.keymap.set('n', 'D', personal.lsp_diagnostics, { desc = 'Show [D]iagnostics' })

          if client.name == 'clangd' then return end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end)
    end,
  }
}
