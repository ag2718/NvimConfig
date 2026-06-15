vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

require('diffview').setup {
  use_icons = false,
  enhanced_diff_hl = true,
  view = {
    default = {
      layout = 'diff1_plain',
    },
    file_history = {
      layout = 'diff1_plain',
    },
  },
  key_bindings = {
    disable_defaults = false,
  },
}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = '[G]it [D]iff view' })
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', { desc = '[G]it [F]ile history' })
vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory<cr>', { desc = '[G]it [F]ile history (repo)' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<cr>', { desc = '[G]it diff [C]lose' })

vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "linematch:60",
  "algorithm:histogram",
}
