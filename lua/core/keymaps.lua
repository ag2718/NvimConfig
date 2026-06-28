vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

vim.keymap.set({'n', 'v'}, '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set({'n', 'v'}, '<leader>D', '"_D', { desc = 'Delete line without yanking' })
vim.keymap.set('n', '<leader>x', '"_x', { desc = 'Delete char without yanking' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<M-w>h', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<M-w>l', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<M-w>j', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<M-w>k', '<C-w><C-k>', { desc = 'Move focus up' })
vim.keymap.set('t', '<M-w>h', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('t', '<M-w>l', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('t', '<M-w>j', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('t', '<M-w>k', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus up' })

-- Window splits
vim.keymap.set('n', '<M-w>v', '<C-w>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<M-w>s', '<C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('n', '<M-w>c', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('t', '<M-w>v', '<C-\\><C-n><C-w>v', { desc = 'Split vertical' })
vim.keymap.set('t', '<M-w>s', '<C-\\><C-n><C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('t', '<M-w>c', '<C-\\><C-n><C-w>c', { desc = 'Close window' })

-- Window resize
vim.keymap.set('n', '<M-w>=', '<C-w>=', { desc = 'Equalize windows' })
vim.keymap.set('n', '<M-w>+', '<C-w>+', { desc = 'Increase height' })
vim.keymap.set('n', '<M-w>-', '<C-w>-', { desc = 'Decrease height' })
vim.keymap.set('n', '<M-w>>', '<C-w>>', { desc = 'Increase width' })
vim.keymap.set('n', '<M-w><', '<C-w><', { desc = 'Decrease width' })
vim.keymap.set('t', '<M-w>=', '<C-\\><C-n><C-w>=', { desc = 'Equalize windows' })
vim.keymap.set('t', '<M-w>+', '<C-\\><C-n><C-w>+', { desc = 'Increase height' })
vim.keymap.set('t', '<M-w>-', '<C-\\><C-n><C-w>-', { desc = 'Decrease height' })
vim.keymap.set('t', '<M-w>>', '<C-\\><C-n><C-w>>', { desc = 'Increase width' })
vim.keymap.set('t', '<M-w><', '<C-\\><C-n><C-w><', { desc = 'Decrease width' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Buffer nav
vim.keymap.set('n', '<Tab>', '<CMD>bnext<CR>', { desc = 'Next buffer'})
vim.keymap.set('n', '<M-Tab>', '<CMD>bprev<CR>', { desc = 'Prev buffer'})

-- Toggle warning-and-below diagnostics, keeping errors visible
local warnings_hidden = false
vim.keymap.set('n', '<leader>td', function()
  warnings_hidden = not warnings_hidden
  if warnings_hidden then
    local only_errors = { severity = { min = vim.diagnostic.severity.ERROR } }
    vim.diagnostic.config { virtual_text = only_errors, underline = only_errors, signs = only_errors }
  else
    vim.diagnostic.config { virtual_text = true, underline = { severity = { min = vim.diagnostic.severity.WARN } }, signs = true }
  end
  vim.notify('Warnings ' .. (warnings_hidden and 'hidden' or 'shown'), vim.log.levels.INFO)
end, { desc = '[T]oggle [D]iagnostics (Warnings)' })
