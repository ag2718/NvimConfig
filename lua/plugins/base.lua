local gh = function(repo) return 'https://github.com/' .. repo end

-- Sneak command (f/F equivalent, two chars)
vim.pack.add { gh 'justinmk/vim-sneak' }
vim.g['sneak#label'] = 1
vim.keymap.set({ 'n', 'x', 'o' }, 'z', '<Plug>Sneak_s')
vim.keymap.set({ 'n', 'x', 'o' }, 'Z', '<Plug>Sneak_S')

vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Surround command
require('mini.surround').setup()

-- Custom text objects
require('mini.ai').setup {
  mappings = { around_next = 'an', inside_next = 'in'},
  n_lines = 500,
  custom_textobjects = {
    a = false,
    f = false,
  },
}

-- Highlights TODOs, BUGs, etc.
vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- Auto-close brackets, quotes, etc. while typing
vim.pack.add { gh 'windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}
