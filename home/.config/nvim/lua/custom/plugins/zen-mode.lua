vim.pack.add { 'https://github.com/folke/zen-mode.nvim' }
require('zen-mode').setup { window = { width = 100 } }
vim.keymap.set('n', '<leader>zz', function()
  require('zen-mode').toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.relativenumber = true
end, { desc = '[Z]en mode' })
