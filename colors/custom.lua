vim.cmd('highlight clear')
vim.o.background = 'dark'
vim.g.colors_name = 'vsdark'

local hi = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local c = {
  bg      = '#101010',
  fg      = '#D4D4D4',
  dim     = '#858585',
  sel     = '#264F78',
  line    = '#2A2D2E',
  blue    = '#569CD6',
  teal    = '#4EC9B0',
  yellow  = '#DCDC9A',
  orange  = '#CE9178',
  green   = '#6A9955',
  numgrn  = '#B5DEA8',
  pink    = '#C586C0',
  red     = '#F44747',
}

-- Editor chrome
hi('Normal',         { fg = c.fg,     bg = c.bg })
hi('NormalFloat',    { fg = c.fg,     bg = '#141414' })
hi('LineNr',         { fg = c.dim })
hi('CursorLineNr',   { fg = '#C6C6C6', bold = true })
hi('CursorLine',     { bg = c.line })
hi('Visual',         { bg = c.sel })
hi('Search',         { fg = '#000000', bg = '#FFFF00' })
hi('IncSearch',      { fg = '#000000', bg = '#FF8000' })
hi('MatchParen',     { bg = '#3B3B3B', bold = true })
hi('Folded',         { fg = c.dim,    bg = '#252526' })
hi('SignColumn',     { bg = c.bg })
hi('EndOfBuffer',    { fg = c.bg })
hi('NonText',        { fg = '#404040' })
hi('WinSeparator',   { fg = '#474747' })
hi('StatusLine',     { fg = c.fg,    bg = c.line })
hi('StatusLineNC',   { fg = '#BBBBBB', bg = '#3C3C3C' })
hi('TabLine',        { fg = c.dim,    bg = '#2D2D2D' })
hi('TabLineSel',     { fg = c.fg,     bg = c.bg })
hi('TabLineFill',    { bg = '#2D2D2D' })
hi('Pmenu',          { fg = c.fg,     bg = '#252526' })
hi('PmenuSel',       { bg = '#094771' })
hi('PmenuThumb',     { bg = '#686868' })
hi('Directory',      { fg = c.blue })
hi('ErrorMsg',       { fg = c.red })
hi('WarningMsg',     { fg = c.yellow })
hi('DiffAdd',        { bg = '#34492E' })
hi('DiffChange',     { bg = '#34492E' })
hi('DiffDelete',     { bg = '#4B1818' })
hi('DiffText',       { bg = '#64795E' })

-- Core syntax
hi('Comment',        { fg = c.green,  italic = true })
hi('String',         { fg = c.orange })
hi('Number',         { fg = c.numgrn })
hi('Float',          { fg = c.numgrn })
hi('Boolean',        { fg = c.blue })
hi('Constant',       { fg = c.fg })
hi('Identifier',     { fg = c.fg })
hi('Function',       { fg = c.yellow })
hi('Keyword',        { fg = c.pink })
hi('Statement',      { fg = c.pink })
hi('Conditional',    { fg = c.pink })
hi('Repeat',         { fg = c.pink })
hi('Exception',      { fg = c.pink })
hi('Operator',       { fg = c.fg })
hi('Type',           { fg = c.fg, italic = true })
hi('StorageClass',   { fg = c.blue })
hi('Structure',      { fg = c.teal })
hi('Special',        { fg = c.yellow })
hi('Delimiter',      { fg = c.fg })
hi('PreProc',        { fg = c.pink })
hi('Todo',           { fg = c.fg,     bold = true })
hi('Error',          { fg = c.red })
hi('Underlined',     { underline = true })

-- Treesitter
hi('@comment',                { fg = c.green,  italic = true })
hi('@string',                 { fg = c.orange })
hi('@string.escape',          { fg = c.yellow })
hi('@number',                 { fg = c.numgrn })
hi('@float',                  { fg = c.numgrn })
hi('@boolean',                { fg = c.blue })
hi('@constant.builtin',       { fg = c.blue })   -- None, True, False
hi('@keyword',                { fg = c.blue })
hi('@keyword.import',         { fg = c.blue })
hi('@keyword.function',       { fg = c.blue })   -- def
hi('@keyword.return',         { fg = c.blue })
hi('@keyword.conditional',    { fg = c.blue })
hi('@keyword.repeat',         { fg = c.blue })
hi('@keyword.operator',       { fg = c.blue })   -- is, not, and, or, in
hi('@keyword.type',           { fg = c.blue })   -- class
hi('@keyword.exception',      { fg = c.pink })
hi('@function',               { fg = c.fg })
hi('@function.call',          { fg = c.fg })
hi('@function.method',        { fg = c.fg })
hi('@function.method.call',   { fg = c.fg })
hi('@function.builtin',       { fg = c.yellow })
hi('@type',                   { fg = c.fg })
hi('@type.builtin',           { fg = c.fg })
hi('@constructor',            { fg = c.fg })
hi('@variable',               { fg = c.fg })
hi('@variable.builtin',       { fg = c.blue })   -- self, cls
hi('@variable.parameter',     { fg = c.fg })
hi('@variable.member',        { fg = c.fg })
hi('@module',                 { fg = c.fg })
hi('@attribute',              { fg = c.yellow }) -- @decorator
hi('@operator',               { fg = c.fg })
hi('@punctuation.delimiter',  { fg = c.fg })
hi('@punctuation.bracket',    { fg = c.fg })
hi('@punctuation.special',    { fg = c.blue })   -- f-string {}

-- LSP semantic tokens
hi('@lsp.type.class',         { fg = c.teal })
hi('@lsp.type.function',      { fg = c.yellow })
hi('@lsp.type.method',        { fg = c.yellow })
hi('@lsp.type.keyword',       { fg = c.blue })
hi('@lsp.type.parameter',     { fg = c.fg })
hi('@lsp.type.variable',      { fg = c.fg })
hi('@lsp.type.property',      { fg = c.fg })
hi('@lsp.type.string',        { fg = c.orange })
hi('@lsp.type.number',        { fg = c.numgrn })
hi('@lsp.type.type',          { fg = c.teal })
hi('@lsp.type.namespace',     { fg = c.fg })
hi('@lsp.mod.defaultLibrary', { fg = c.yellow })

-- Diagnostics
hi('DiagnosticError',            { fg = c.red })
hi('DiagnosticWarn',             { fg = c.yellow })
hi('DiagnosticInfo',             { fg = c.blue })
hi('DiagnosticHint',             { fg = c.blue })
hi('DiagnosticUnderlineError',   { sp = c.red,    undercurl = true })
hi('DiagnosticUnderlineWarn',    { sp = c.yellow, undercurl = true })
hi('DiagnosticUnderlineInfo',    { sp = c.blue,   undercurl = true })
hi('DiagnosticUnderlineHint',    { sp = c.blue,   undercurl = true })
hi('DiagnosticVirtualTextError', { fg = c.red,    italic = true })
hi('DiagnosticVirtualTextWarn',  { fg = c.yellow, italic = true })
hi('DiagnosticVirtualTextInfo',  { fg = c.blue,   italic = true })
hi('DiagnosticVirtualTextHint',  { fg = c.blue,   italic = true })
hi('LspInlayHint',               { fg = c.dim,    bg = '#252526', italic = true })
hi('LspReferenceText',           { bg = '#3A3D41' })
hi('LspReferenceRead',           { bg = '#3A3D41' })
hi('LspReferenceWrite',          { bg = '#3A3D41' })

-- GitSigns
hi('GitSignsAdd',    { fg = c.green })
hi('GitSignsChange', { fg = c.blue })
hi('GitSignsDelete', { fg = c.red })

-- Telescope
hi('TelescopeBorder',       { fg = '#474747', bg = '#141414' })
hi('TelescopeNormal',       { fg = c.fg,      bg = '#141414' })
hi('TelescopePromptPrefix', { fg = c.blue })
hi('TelescopeSelection',    { bg = c.sel })
hi('TelescopeMatching',     { fg = c.yellow,  bold = true })

-- Diffview
hi('DiffviewFolderName',    { fg = c.fg })
hi('DiffviewFolderSign',    { fg = c.fg })
hi('DiffviewDiffDeleteDim', { fg = '#2a2a2a' })
