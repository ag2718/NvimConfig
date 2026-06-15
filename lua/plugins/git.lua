local gh = function(repo) return 'https://github.com/' .. repo end

-- See git signs in the gutter, go to prev / next hunk
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
    vim.keymap.set('n', ']c', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
    vim.keymap.set('n', '[c', gs.prev_hunk, { buffer = bufnr, desc = 'Prev hunk' })
  end,
}

-- Nice diff viewer for nvim
vim.pack.add { gh 'sindrets/diffview.nvim' }
require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    default = { layout = 'diff2_horizontal' },
    file_history = { layout = 'diff2_horizontal' },
  },
  key_bindings = { disable_defaults = false },
}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = '[G]it [D]iff view' })
vim.keymap.set('n', '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', { desc = '[G]it [F]ile history' })
vim.keymap.set('n', '<leader>gF', '<cmd>DiffviewFileHistory<cr>', { desc = '[G]it [F]ile history (repo)' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<cr>', { desc = '[G]it diff [C]lose' })

-- Options for diff view and algorithm
vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'linematch:60',
  'algorithm:histogram',
}
