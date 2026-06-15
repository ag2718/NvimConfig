local gh = function(repo) return 'https://github.com/' .. repo end

-- Language-specific parsing

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

require('nvim-treesitter').install {
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
}

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
