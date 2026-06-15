local gh = function(repo) return 'https://github.com/' .. repo end

-- Formatter
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local enabled = {}
    if enabled[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    end
  end,
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {},
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
