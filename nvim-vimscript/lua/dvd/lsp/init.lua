local has_lsp, lspconfig = pcall(require, 'lspconfig')
local lspconfig_util = pcall(require, 'lspconfig.util')

if not has_lsp then
    return
end

local cmp = require 'cmp'
local nvim_status = require 'lsp-status'

local telescope_mapper = require 'dvd.telescope.mappings'
local status = require 'dvd.lsp.status'
status.activate()

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        })
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },

        -- For luasnip user.
        { name = 'luasnip' },

        { name = 'buffer' },
    })
})


-- check the vim.keymap.set("mode", "key", "right_side_function_call", {buffer=0})
-- See Bash2Basics tutorial

local mapper = function(mode, key, f)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. f .. "<CR>", {noremap = true, silent = true})
end

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
    -- Not used for now, but it might turn useful
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    -- require('completion').on_attach(client)
    nvim_status.on_attach(client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },

    filetypes = {"c", "cpp", "cxx", "h", "hpp", "hxx", "ipp", "objc", "objcpp"},

    on_init = custom_init,
    on_attach = custom_attach,

    -- Required for lsp-status
    init_options = {
        clangdFileStatus = true,
    },

    handlers = nvim_status.extensions.clangd.setup(),
    capabilities = updated_capabilities,
    -- capabilities = nvim_status.capabilities,
})

lspconfig.yamlls.setup({
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    -- capabilities = nvim_status.capabilities,
})

lspconfig.pylsp.setup({
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    -- capabilities = nvim_status.capabilities,
})

lspconfig.cmake.setup({
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    -- capabilities = nvim_status.capabilities,
})

lspconfig.rust_analyzer.setup({
    cmd = { "rustup", "run", "nightly", "rust-analyzer"},
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
})
