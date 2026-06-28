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
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation (diff-aware: falls through to native ]c/[c while in diff mode)
    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Next git [h]unk' })

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Prev git [h]unk' })

    -- Actions
    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (changes in this file)' })

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'select git hunk' })
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

-- Suppress LSP diagnostics on historical (old-revision) diffview buffers, whose
-- names contain diffview://. These are read-only snapshots, so Pyright flags
-- stale imports against the current env and produces false errors in the left
-- pane. DiagnosticChanged fires whenever diagnostics are published for a buffer,
-- regardless of how/when the LSP client attached; enable(false) sets a per-buffer
-- disabled flag and hides them (via hide(), so it won't re-trigger this autocmd).
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    if vim.api.nvim_buf_get_name(args.buf):find('diffview://', 1, true) then
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end
  end,
})

-- Options for diff view and algorithm
vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'linematch:60',
  'algorithm:histogram',
}
