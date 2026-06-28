vim.loader.enable()

package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'
  .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua'
package.cpath = package.cpath .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/lib/lua/5.1/?.so'

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    local function run_build(cmd, cwd)
      local result = vim.system(cmd, { cwd = cwd }):wait()
      if result.code ~= 0 then
        local out = result.stderr ~= '' and result.stderr or result.stdout or 'No output.'
        vim.notify(('Build failed for %s:\n%s'):format(name, out), vim.log.levels.ERROR)
      end
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build({ 'make' }, ev.data.path)
    elseif name == 'LuaSnip' and vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
      run_build({ 'make', 'install_jsregexp' }, ev.data.path)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'plugins.base'

if not vim.g.vscode then
  require 'plugins.ui'
  require 'plugins.telescope'
  require 'plugins.lsp'
  require 'plugins.formatting'
  require 'plugins.lint'
  require 'plugins.completion'
  require 'plugins.treesitter'
  require 'plugins.git'
end

-- vim: ts=2 sts=2 sw=2 et
