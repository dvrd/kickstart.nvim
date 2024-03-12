return {
  {
    dir = '$PROJ_PATH/kukenan.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kukenan'
    end,
  },
}
