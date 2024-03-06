return {
  {
    dir = '~/dev/projects/kukenan.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kukenan'
    end,
  },
}
