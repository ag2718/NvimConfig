vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then vim.cmd("checktime") end
  end,
})

-- Hand off binary/non-text files to the OS default application. `open` is
-- macOS-only; Linux uses `xdg-open` and Windows uses `start`.
local function os_open(file)
  if vim.fn.has('mac') == 1 then
    vim.fn.system({ 'open', file })
  elseif vim.fn.has('win32') == 1 then
    vim.fn.system({ 'cmd', '/c', 'start', '', file })
  else
    vim.fn.system({ 'xdg-open', file })
  end
end

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = {
    "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.bmp", "*.ico", "*.tiff", "*.tif",
    "*.pdf",
    "*.mp4", "*.mov", "*.avi", "*.mkv", "*.webm", "*.m4v", "*.flv", "*.wmv",
    "*.mp3", "*.wav", "*.flac", "*.aac", "*.ogg", "*.m4a", "*.wma",
    "*.zip", "*.tar", "*.gz", "*.bz2", "*.xz", "*.7z", "*.rar",
    "*.doc", "*.docx", "*.xls", "*.xlsx", "*.ppt", "*.pptx", "*.key", "*.pages", "*.numbers",
  },
  callback = function(args)
    os_open(args.file)
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force = true })
      end
    end, 100)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
