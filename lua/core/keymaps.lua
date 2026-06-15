vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

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
