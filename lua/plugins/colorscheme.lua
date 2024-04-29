return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      }
      vim.cmd.colorscheme 'cyberdream'
    end,
  },
  {
    dir = os.getenv 'PROJ_PATH' .. '/kukenan.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'kukenan'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        contrast = 'hard',
      }
      vim.o.background = 'dark'
      -- vim.cmd.colorscheme 'gruvbox'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
