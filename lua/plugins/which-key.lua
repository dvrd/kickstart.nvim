return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()

      require('which-key').register {
        { "", group = "[S]earch" },
        { "", desc = "<leader>c_", hidden = true },
        { "", group = "[C]ode" },
        { "", group = "[D]ocument" },
        { "", desc = "<leader>d_", hidden = true },
        { "", group = "[R]ename" },
        { "", group = "[R]est" },
        { "", group = "[G]it" },
        { "", desc = "<leader>s_", hidden = true },
        { "", desc = "<leader>g_", hidden = true },
        { "", group = "[W]orkspace" },
        { "", desc = "<leader>w_", hidden = true },
        { "", desc = "<leader>r_", hidden = true, mode = { "n", "n" } },
      }
    end,
  },
}
