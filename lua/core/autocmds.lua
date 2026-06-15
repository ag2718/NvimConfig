vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  callback = function() vim.cmd 'checktime' end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
