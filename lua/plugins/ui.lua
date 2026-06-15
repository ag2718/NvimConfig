local gh = function(repo) return 'https://github.com/' .. repo end

-- Detect indentation in buffer
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Helper popup for what keys can complete a command
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 500,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}

-- File icons (required by diffview, lualine, etc.)
vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }
require('nvim-web-devicons').setup({
  color_icons=false
})

-- Theme
vim.cmd.colorscheme 'custom'

-- Statusline
vim.pack.add { gh 'nvim-lualine/lualine.nvim' }
require('lualine').setup {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'diagnostics' },
    lualine_c = { {
      'buffers',
      buffers_color = {
        inactive = { fg = '#606060', bg = nil },
      },
    } },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

-- File explorer
vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open()
end, { desc = 'File explorer' })

