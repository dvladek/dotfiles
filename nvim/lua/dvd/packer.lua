return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Colorschemes
    use("chriskempson/base16-vim")
    use("gruvbox-community/gruvbox")

    -- Git file system
    use("TimUntersberger/neogit")
    use("ThePrimeagen/git-worktree.nvim")
    use("mbbill/undotree")

    -- Telescope prerequisite.
    use("nvim-lua/plenary.nvim")

    -- Telescope plugin
    use("nvim-telescope/telescope.nvim")

    -- Vim global marks
    use("ThePrimeagen/harpoon")
end)
