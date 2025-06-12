vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local silent = {silent = true}

vim.api.nvim_set_keymap('v', '<leader><leader>', 'gc',
    { desc = 'Comment toggle in selection', silent = true})
vim.api.nvim_set_keymap('n', '<leader><leader>', 'gcc',
    { desc = 'Comment toggle in line', silent = true})

vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>',
    { desc = 'LSP definition', noremap = true, silent = true})

if vim.fn.exists('g:vscode') == 0 then
  
  vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('i', '<MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('v', '<MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('', '<MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('n', '<2-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('i', '<2-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('v', '<2-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('', '<2-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('n', '<3-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('i', '<3-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('v', '<3-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  vim.api.nvim_set_keymap('', '<3-MiddleMouse>', '<nop>',
      { desc = 'Disable middle mouse paste', silent = true})
  
  vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', 
      { desc = 'Telescope find files', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', 
      { desc = 'Telescope live grep', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope grep_string<cr>', 
      { desc = 'Telescope find given string', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', 
      { desc = 'Telescope find open buffer', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>', 
      { desc = 'Telescope find in current buffer', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope command_history<cr>', 
      { desc = 'Telescope find in command history', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope registers<cr>', 
      { desc = 'Telescope find in registers', noremap = true, silent = true})
  
  vim.api.nvim_set_keymap('n', '<leader>ee', '<cmd>NvimTreeToggle<cr>', 
      { desc = 'Tree toggle', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>ef', '<cmd>NvimTreeFocus<cr>', 
      { desc = 'Tree toggle', noremap = true, silent = true})
  
  vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', 
      { desc = 'Gitsigns diff', noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>gh', '<cmd>Gitsigns preview_hunk_inline<cr>', 
      { desc = 'Gitsigns preview hunk inline', noremap = true, silent = true})
  
  
end
