-- ThePrimeagen's keymaps and autocmds (github.com/ThePrimeagen/init.lua), adapted to
-- coexist with kickstart's <C-hjkl> window navigation and <leader>s search group.

local map = vim.keymap.set

-- netrw project view
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
map('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew (netrw)' })

-- Move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor in place / centred
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '=ap', "ma=ap'a")

-- greatest remap ever: paste over selection without losing the register
map('x', '<leader>p', [["_dP]], { desc = '[P]aste, keep register' })
-- next greatest remap ever: system clipboard yank
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = '[Y]ank line to clipboard' })
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete to void' })

-- This is going to get me cancelled
map('i', '<C-c>', '<Esc>')
map('n', 'Q', '<nop>')

-- Quickfix / location list (Neovim already ships ]q [q ]l [l; these centre too)
map('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix' })
map('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Prev quickfix' })
map('n', ']l', '<cmd>lnext<CR>zz', { desc = 'Next loclist' })
map('n', '[l', '<cmd>lprev<CR>zz', { desc = 'Prev loclist' })

-- Replace word under cursor (kickstart owns <leader>s, so capital S)
map('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]ubstitute word under cursor' })
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file e[x]ecutable' })

-- ThePrimeagen's tmux sessionizer (~/.local/bin/tmux-sessionizer)
map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'tmux sessionizer' })

-- Strip trailing whitespace on save
local group = vim.api.nvim_create_augroup('prime', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
