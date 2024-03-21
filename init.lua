require 'options'
require 'keymaps'
require 'autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup 'plugins'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.lsp.start {
      name = 'asgard',
      -- cmd = { '/Users/kaku/dev/projects/asgard/target/release/asgard' },
      cmd = { '/Users/kaku/dev/oss/ols/ols' },
      on_attach = function(client)
        vim.notify 'LSP started'
      end,
    }
  end,
})
