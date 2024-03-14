return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'eslint_d', { 'prettierd', 'prettier' } },
        zsh = { 'shfmt' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
}
