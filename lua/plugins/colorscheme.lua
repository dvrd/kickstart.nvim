return {
  {
    dir = os.getenv 'PROJ_PATH' .. '/kukenan.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kukenan'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
