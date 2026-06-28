local gh = function(repo) return 'https://github.com/' .. repo end

-- Language-specific parsing

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }
vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-textobjects' }

require('nvim-treesitter').install {
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
}

require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}

local select = require('nvim-treesitter-textobjects.select').select_textobject
local move = require('nvim-treesitter-textobjects.move')
local swap = require('nvim-treesitter-textobjects.swap')

local function sel(capture)
  return function() select(capture) end
end

for _, map in ipairs {
  { { 'x', 'o' }, 'af', sel('@function.outer') },
  { { 'x', 'o' }, 'if', sel('@function.inner') },
  { { 'x', 'o' }, 'ac', sel('@class.outer') },
  { { 'x', 'o' }, 'ic', sel('@class.inner') },
  { { 'x', 'o' }, 'aF', sel('@call.outer') },
  { { 'x', 'o' }, 'iF', sel('@call.inner') },
  { { 'x', 'o' }, 'aa', sel('@parameter.outer') },
  { { 'x', 'o' }, 'ia', sel('@parameter.inner') },
  { { 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer') end },
  { { 'n', 'x', 'o' }, ']c', function() move.goto_next_start('@class.outer') end },
  { { 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner') end },
  { { 'n', 'x', 'o' }, ']F', function() move.goto_next_end('@function.outer') end },
  { { 'n', 'x', 'o' }, ']C', function() move.goto_next_end('@class.outer') end },
  { { 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer') end },
  { { 'n', 'x', 'o' }, '[c', function() move.goto_previous_start('@class.outer') end },
  { { 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner') end },
  { { 'n', 'x', 'o' }, '[F', function() move.goto_previous_end('@function.outer') end },
  { { 'n', 'x', 'o' }, '[C', function() move.goto_previous_end('@class.outer') end },
  { 'n', '<leader>a', function() swap.swap_next('@parameter.inner') end },
  { 'n', '<leader>A', function() swap.swap_previous('@parameter.inner') end },
} do
  vim.keymap.set(map[1], map[2], map[3])
end

local function try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)
  if vim.treesitter.query.get(language, 'indents') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed = require('nvim-treesitter').get_installed 'parsers'
    if vim.tbl_contains(installed, language) then
      try_attach(buf, language)
    elseif vim.tbl_contains(available, language) then
      require('nvim-treesitter').install(language):await(function()
        try_attach(buf, language)
      end)
    else
      try_attach(buf, language)
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
})
