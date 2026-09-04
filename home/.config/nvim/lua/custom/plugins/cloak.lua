-- Hides secrets in .env files (toggle with <leader>tc)
vim.pack.add { 'https://github.com/laytan/cloak.nvim' }
require('cloak').setup {
  enabled = true,
  cloak_character = '*',
  highlight_group = 'Comment',
  patterns = { { file_pattern = { '.env*', 'wrangler.toml', '.dev.vars' }, cloak_pattern = '=.+' } },
}
vim.keymap.set('n', '<leader>tc', '<cmd>CloakToggle<CR>', { desc = '[T]oggle [C]loak' })
