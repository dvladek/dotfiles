local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

local lspinstall = require("nvim-lsp-installer")

lspinstall.setup({
    ensure_installed = {
        "clangd",
        "cmake",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "texlab",
        "pyright",
        "rust_analyzer",
        "taplo",
        "tsserver",
        "yamlls",
    },

    automatic_installation = true,
})

vim.opt.completeopt = {"menu", "menuone", "noselect"}

local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-l>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        })
    }),

    sources = {
        { name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
        { name = "path" },
        -- { name = "cmp_tabnine" },
	},

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[snip]",
                buffer = "[buf]",
                path = "[path]",
                nvim_lua = "[api]",
                -- tn = "[TabNine]",
            },
        }),
    },

    experimental = {
        native_menu = false,
    }
})


local lspconfig = require("lspconfig")

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
    -- local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    nnoremap("K", function() vim.lsp.buf.hover() end)
    nnoremap("gD", function() vim.lsp.buf.definition() end)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, lsp_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

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

    --handlers = lsp_status and lsp_status.extensions.clangd.setup(),
    capabilities = updated_capabilities,
})

lspconfig.cmake.setup({
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
})

lspconfig.pyright.setup({
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
})

lspconfig.rust_analyzer.setup({
    cmd = { "rustup", "run", "nightly", "rust-analyzer"},
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
})
