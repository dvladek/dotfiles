return {
  'folke/zen-mode.nvim',

  config = function()
    vim.keymap.set("n", "<leader>z", function()
      require("zen-mode").toggle({})
    end, { desc = '[Z]en mode' })
  end
}

