local has_lsp, lspconfig = pcall(require, 'lspconfig')
if not has_lsp then
  return
end

local nvim_status = require('lsp-status')

local telescope_mapper = require('dvd.telescope.mappings')

_ = require('lspkind').init()
_ = require('dvd.lsp.status')
-- status.activate()

local mapper = function(mode, key, f)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. f .. "<CR>", {noremap = true, silent = true})
end

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },

    on_attach = require('completion').on_attach,

    -- Required for lsp-status
    init_options = {
        clangdFileStatus = true
    },

    handlers = nvim_status.extensions.clangd.setup(),
    capabilities = nvim_status.capabilities,
})

lspconfig.pyls.setup({
    on_attach = require('completion').on_attach,

    handlers = nvim_status.extensions.pyls_ms.setup(),
})

lspconfig.cmake.setup({
    on_attach = require('completion').on_attach
})

--[[
local sumneko_root_path = '/Users/dvladek/Development/code/sumneko/lua-language-server'
local sunmeko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = require('completion').on_attach,

    settings = {
        Lua = {

            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },

            diagnostics = {
                -- Get the language server to recognize the `vim` global
                enable = true,
                globals = {'vim'},
            },

            workspace = {
                -- Make the server aware of Neovim runtime files
--                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
           },
        },
    },
}

--]]
