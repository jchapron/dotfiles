vim.pack.add { 'https://github.com/folke/trouble.nvim' }
require('trouble').setup {}
vim.keymap.set('n', '<leader>tt', function() require('trouble').toggle 'diagnostics' end, { desc = '[T]oggle [T]rouble' })
vim.keymap.set('n', ']t', function() require('trouble').next { skip_groups = true, jump = true } end, { desc = 'Next trouble item' })
vim.keymap.set('n', '[t', function() require('trouble').prev { skip_groups = true, jump = true } end, { desc = 'Prev trouble item' })
