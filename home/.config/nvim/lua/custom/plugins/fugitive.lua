vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('prime-fugitive', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then return end
    local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
    vim.keymap.set('n', '<leader>p', function() vim.cmd.Git 'push' end, opts)
    vim.keymap.set('n', '<leader>P', function() vim.cmd.Git { 'pull', '--rebase' } end, opts)
    vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
  end,
})

-- Merge conflicts: take left / right
vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'Diff: take ours' })
vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'Diff: take theirs' })
