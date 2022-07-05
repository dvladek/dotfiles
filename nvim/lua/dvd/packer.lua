return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Start screen
    use("mhinz/vim-startify")

    -- Colorschemes
    use("base16-project/base16-vim")
    use("arcticicestudio/nord-vim")
    use("gruvbox-community/gruvbox")

    -- Icons
    use("kyazdani42/nvim-web-devicons")

    -- statusline
    use("tjdevries/express_line.nvim")
    use("j-hui/fidget.nvim")
    -- use("feline-nvim/feline.nvim")

    -- Color parsing
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use("nvim-treesitter/playground")

    -- Notifications (some day)
    -- use("rcarriga/nvim-notify")

    -- Git file system
    use("TimUntersberger/neogit")
    use("ThePrimeagen/git-worktree.nvim")
    use("mbbill/undotree")

    -- Telescope prerequisite.
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    -- Telescope plugin
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    -- use("nvim-telescope/telescope-bibtex.nvim")

    -- Vim global marks
    use("ThePrimeagen/harpoon")

    -- Language server protocol
    use("williamboman/nvim-lsp-installer")
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    -- use("cmp-tabnine")

    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- TODO(dvladek): I need to understand DAP better before using it!
    -- Debug Adapter Protocol
    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")
    -- use("theHamsta/nvim-dap-virtual-text")

    --use("mfussenegger/nvim-dap-python")

    -- Adds client-side code for codelenses commands that are not available in the language servers.
    -- use("ericpubu/lsp_codelens_extensions.nvim")

    use("wbthomason/lsp-status.nvim")

end)
