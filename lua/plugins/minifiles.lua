local MiniFiles = require("mini.files")

vim.keymap.set('n', '<leader>e', function()
  MiniFiles.open()
end, { desc = 'File explorer' })

local show_dotfiles = true
local filter_show = function() return true end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  MiniFiles.refresh({ content = { filter = show_dotfiles and filter_show or filter_hide } })
end

MiniFiles.setup({
  content = {
    filter = filter_hide,
  },
  windows = {
    preview = true,
    width_nofocus = 20,
    width_focus = 30,
    width_preview = 40,
  },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf = args.data.buf_id
    vim.api.nvim_buf_call(buf, function()
      vim.wo.number = true
      vim.wo.relativenumber = true
    end)
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf, desc = "Toggle dotfiles" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    vim.wo[args.data.win_id].number = true
    vim.wo[args.data.win_id].relativenumber = true
  end,
})

-- Image preview in mini.files
local mf_preview_image = nil
local mf_preview_path = nil
local mf_image_win = nil
local image_exts = { png = true, jpg = true, jpeg = true, gif = true, webp = true, avif = true, bmp = true, tiff = true, tif = true }

local function clear_preview_image()
  if mf_preview_image then
    pcall(function() mf_preview_image:clear() end)
    mf_preview_image = nil
    mf_preview_path = nil
    mf_image_win = nil
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    if not vim.g.have_image then return end
    local win = args.data.win_id
    local buf = args.data.buf_id
    if not vim.api.nvim_win_is_valid(win) then return end

    local ok, explorer = pcall(MiniFiles.get_explorer_state)
    if not ok or not explorer or not explorer.branch then return end

    local preview_path = explorer.branch[#explorer.branch]
    if not preview_path or type(preview_path) ~= "string" then return end
    local ok_dir, is_dir = pcall(vim.fn.isdirectory, preview_path)
    if not ok_dir or is_dir == 1 then return end

    local preview_win = explorer.windows and explorer.windows[#explorer.windows]
    if not preview_win or win ~= preview_win.win_id then return end

    local path = preview_path
    if vim.fn.filereadable(path) ~= 1 then return end

    local ext = (path:match("%.(%w+)$") or ""):lower()
    if not image_exts[ext] then
      clear_preview_image()
      return
    end

    clear_preview_image()

    local max_w = math.min(60, math.floor(vim.o.columns * 0.4))
    local max_h = math.min(30, vim.o.lines - 6)

    local config = vim.api.nvim_win_get_config(win)
    config.width = max_w
    config.height = max_h
    vim.api.nvim_win_set_config(win, config)

    vim.bo[buf].modifiable = true
    local blank = {}
    for _ = 1, max_h do blank[#blank + 1] = "" end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, blank)
    -- Leave the buffer modifiable: mini.files reuses preview buffers and writes
    -- file/dir content into them via nvim_buf_set_lines on refresh (e.g. after a
    -- sync/delete). Locking it here causes "Buffer is not 'modifiable'" errors.

    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(win) then return end
      local img = require("image").from_file(path, {
        window = win,
        buffer = buf,
        x = 0,
        y = 0,
        width = max_w,
        height = max_h,
      })
      if img then
        img:render()
        mf_preview_image = img
        mf_preview_path = path
        mf_image_win = win
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerClose",
  callback = clear_preview_image,
})

-- Center explorer on screen
local mf_center_pending = false
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    if args.data.win_id ~= mf_image_win then
      local config = vim.api.nvim_win_get_config(args.data.win_id)
      config.height = math.min(config.height, 20)
      vim.api.nvim_win_set_config(args.data.win_id, config)
    end

    if mf_center_pending then return end
    mf_center_pending = true
    vim.schedule(function()
      mf_center_pending = false

      local mf_wins = {}
      local min_col, max_right = math.huge, 0
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(w) then
          local c = vim.api.nvim_win_get_config(w)
          if c.relative ~= "" then
            local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
            if ft == "minifiles" or ft == "minifiles-help" then
              local col = type(c.col) == "table" and c.col[false] or c.col
              table.insert(mf_wins, { win = w, col = col, width = c.width })
              if col < min_col then min_col = col end
              local right = col + c.width + 2
              if right > max_right then max_right = right end
            end
          end
        end
      end
      if #mf_wins == 0 then return end

      local total_width = max_right - min_col
      local target_left = math.floor((vim.o.columns - total_width) / 2)
      local shift = target_left - min_col
      if shift == 0 then return end

      for _, e in ipairs(mf_wins) do
        if vim.api.nvim_win_is_valid(e.win) then
          local c = vim.api.nvim_win_get_config(e.win)
          local col = type(c.col) == "table" and c.col[false] or c.col
          c.col = col + shift
          vim.api.nvim_win_set_config(e.win, c)
        end
      end
    end)
  end,
})
