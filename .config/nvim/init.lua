-- load all config files

require('options')
require('keymaps')

-- check if in vscode
if vim.fn.exists('g:vscode') == 0 then
  require('themes') -- at end to overwrite other plugins colors
  require('plugins')
else
    require('plugins_vscode')
end

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.85
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0.03
end
