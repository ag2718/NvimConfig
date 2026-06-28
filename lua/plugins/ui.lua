local gh = function(repo) return 'https://github.com/' .. repo end

-- Detect indentation in buffer
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Indentation guides, even on blank lines
vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}

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

-- Image rendering. Requires the ImageMagick `magick` CLI (ImageMagick 7; note
-- that many Linux distros only ship the v6 `convert` binary) and a terminal that
-- speaks the kitty graphics protocol (kitty/WezTerm/Ghostty). Gate on `magick`
-- so the config loads cleanly on hosts without it; mini.files reads vim.g.have_image.
vim.g.have_image = vim.fn.executable('magick') == 1
if vim.g.have_image then
  vim.pack.add { gh '3rd/image.nvim' }
  require("image").setup({
    backend = "kitty",
    processor = "magick_cli",
    integrations = {},
    hijack_file_patterns = {},
  })
end

-- File explorer
require("plugins.minifiles")

-- Markdown rendering
vim.pack.add({
    "https://github.com/OXY2DEV/markview.nvim",
})

-- Lighten the code block / inline code background for a bit more contrast.
-- These control how far the highlight bg is mixed away from the Normal bg
-- (dark-theme defaults are 0.15 / 0.2).
vim.g.markview_code_alpha = 0.5
vim.g.markview_inline_code_alpha = 0.2

require("markview").setup({
    markdown = {
        -- Disable the gutter signs (code blocks + headings).
        code_blocks = {
            sign = false,
        },
        -- Drop the icon/number labels; use a plain colored line background
        -- per level (highlights defined in colors/custom.lua).
        headings = {
            heading_1 = { style = "simple", hl = "MdHeading1" },
            heading_2 = { style = "simple", hl = "MdHeading2" },
            heading_3 = { style = "simple", hl = "MdHeading3" },
            heading_4 = { style = "simple", hl = "MdHeading4" },
            heading_5 = { style = "simple", hl = "MdHeading5" },
            heading_6 = { style = "simple", hl = "MdHeading6" },
            setext_1 = { style = "simple", hl = "MdHeading1" },
            setext_2 = { style = "simple", hl = "MdHeading2" },
        },
    },
})
