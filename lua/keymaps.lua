-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- Disable in lazygit and ignore key in which key
vim.keymap.set('t', '<Esc><Esc>', function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name:match 'lazygit' then
    return '<Esc>'
  else
    return '<C-\\><C-n>'
  end
end, { expr = true, nowait = true, desc = 'which_key_ignore' })

--checking for key mappings
vim.api.nvim_set_keymap('n', '<C-w>s', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':split<CR>', { noremap = true, silent = true })

-- Shift tab to dedent
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Testing new keymaps
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move line down/up
vim.keymap.set('n', '<m-d>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<m-u>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })

-- Add comment
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Quit
vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { desc = 'Quit All' })

-- windows
vim.keymap.set('n', '<leader>ww', '<C-W>p', { desc = 'Other Window', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
vim.keymap.set('n', '<leader>w-', '<C-W>v', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>w|', '<C-W>s', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>v', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>s', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>wc', '<cmd>windo diffthis<cr>', { desc = '[c]ompare [w]indows' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- tabs
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Run Lua code
vim.keymap.set('n', '<leader>lr', '<cmd>.lua<CR>', { desc = 'Run current line as Lua code' })
vim.keymap.set('v', '<leader>lR', [[<Esc><cmd>'<,'>lua<CR>]], { desc = 'Run selected lines as Lua code' })

-- Iswap
vim.keymap.set('n', '<leader>is', ':ISwapWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>in', ':ISwapNodeWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ih', ':ISwapNode<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>io', ':ISwap<CR>', { noremap = true, silent = true })

-- Autocommands go below ----
--  See `:help lua-guide-autocommands`

-- vim: ts=2 sts=2 sw=2 et
