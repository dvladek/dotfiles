return {
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip' },

    version = '*',

    opts = {
      snippets = { preset = 'luasnip' },
      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'select_and_accept' },

        ['<Tab>'] = { 'select_next', 'fallback' },

        ['<C-k>'] = { 'snippet_forward', 'fallback' },
        ['C-t'] = { 'snippet_backward', 'fallback' },

        ['<C-y>'] = {},
        ['<C-n>'] = {},
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true },

      completion = {
        -- menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end },
        ghost_text = { enabled = true }
      }
    },

  },

  {
    "L3MON4D3/LuaSnip",

    version = "v2.*",

    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/config/snippets" } })
        end,
      },
    },

    opts = {
      -- This tells LuaSnip to remember to keep around the last snippet.
      -- You can jump back into it even if you move outside of the selection
      history = true,

      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",

      -- Autosnippets:
      enable_autosnippets = true,
    },

    config = function()
      local ls = require('luasnip')
      ls.filetype_extend('javascript', { 'jsdoc' })

      vim.keymap.set({ 'i', 's' }, '<C-k>', function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<C-j>', function() ls.jump(-1) end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<C-ö>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  }
}
