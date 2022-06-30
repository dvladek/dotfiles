return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Start screen
    use("mhinz/vim-startify")

    -- Colorschemes
    use("chriskempson/base16-vim")
    use("gruvbox-community/gruvbox")

    -- Icons
    use("kyazdani42/nvim-web-devicons")

    -- Color parsing
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use("nvim-treesitter/playground")

    -- Git file system
    use("TimUntersberger/neogit")
    use("ThePrimeagen/git-worktree.nvim")
    use("mbbill/undotree")

    -- Telescope prerequisite.
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    -- Telescope plugin
    use("nvim-telescope/telescope.nvim")

    -- Vim global marks
    use("ThePrimeagen/harpoon")

    -- Language server protocol
    use("williamboman/nvim-lsp-installer")
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("glepnir/lspsaga.nvim")
    use("nvim-lua/lsp_extensions.nvim")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    -- use("cmp-tabnine")

    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- TODO(dvladek): Add all DAP stuff first!!!
    -- Adds client-side code for codelenses commands that are not available in the language servers.
    -- use("ericpubu/lsp_codelens_extensions.nvim")
    --
    --
    --
    -- This is a Neovim plugin/library for generating statusline components from the built-in LSP client.
    -- use("wbthomason/lsp-status.nvim")



end)
