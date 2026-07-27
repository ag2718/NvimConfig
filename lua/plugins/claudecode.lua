local gh = function(repo) return 'https://github.com/' .. repo end

-- Claude Code integration (WebSocket bridge to the Claude Code CLI).
-- We use the built-in native terminal provider instead of snacks.nvim, so
-- there's no snacks dependency to pull in. The only thing given up is the
-- snacks floating-window terminal UI; Claude Code opens in a plain :terminal
-- split instead. The snacks picker integration is unused here anyway (this
-- config uses telescope + mini.files).
vim.pack.add { gh 'coder/claudecode.nvim' }
require('claudecode').setup {
  terminal = { provider = 'native' },
  -- After adding context (buffer, selection, tree file) jump into the Claude
  -- terminal instead of just revealing it. All the :ClaudeCode{Add,Send,TreeAdd}
  -- commands route through send_at_mention, which calls terminal.open() (focus)
  -- when this is set, else terminal.ensure_visible() (show but keep cursor put).
  -- This is the supported hook -- chaining :ClaudeCodeFocus in a keymap races
  -- the debounced WebSocket send. Works with the native provider (#228 warning
  -- only applies to external/none providers that run Claude outside nvim).
  focus_after_send = true,
}

-- Keymaps. This config loads plugins eagerly via vim.pack, so the upstream
-- lazy.nvim `cmd`/`keys` lazy-loading spec is unnecessary: the :ClaudeCode*
-- commands are created the moment setup() runs above.
local map = vim.keymap.set

require('which-key').add { { '<leader>a', group = 'AI/Claude Code' } }

map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
map('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
map('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })

-- Diff management
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

-- In file-explorer buffers, <leader>as adds the file under the cursor to
-- Claude's context (upstream gates this to these filetypes via `ft`).
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw', 'snacks_picker_list' },
  callback = function(args)
    map('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = args.buf, desc = 'Add file' })
  end,
})
