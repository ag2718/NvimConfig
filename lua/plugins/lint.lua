local gh = function(repo) return 'https://github.com/' .. repo end

-- Linting: runs standalone CLI linters and surfaces their output as Neovim
-- diagnostics. Complements the LSP servers (e.g. pyright) — pyright does type
-- checking, ruff adds style/lint rules (line length, import order, code smells).
vim.pack.add { gh 'mfussenegger/nvim-lint' }

local lint = require('lint')
lint.linters_by_ft = {
  python = { 'ruff' },
  markdown = { 'markdownlint' },
}

-- Run the linter on common edit/enter events. Skip non-modifiable buffers (e.g.
-- LSP hover popups) to avoid superfluous noise.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
