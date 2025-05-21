-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- when focus is lost, mode is changed, text is changed, or buffer is entered
-- vim.api.nvim_create_autocmd({ 'FocusLost', 'TextChanged', 'BufEnter' }, {
--   callback = function()
--     -- Update the buffer if it's modified, not readonly, and not a special buffer
--     if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
--       vim.api.nvim_command 'silent! update'
--     end
--   end,
-- })

-- Open MiniFiles
vim.keymap.set('n', '<leader>o', ':lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', { desc = '[O]pen MiniFiles' })

-- Insert debugger statement
vim.keymap.set('n', '<leader>db', ':normal! odebugger<Esc>', { desc = 'Insert ruby debugger' })

-- Copy relative path to clipboard
vim.keymap.set('n', '<leader>cp', ':let @+=expand("%")<CR>', { desc = 'Copy relative path to clipboard' })

-- Copy the nearest Minitest test line number to the clipboard
vim.keymap.set('n', '<leader>ct', function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand '%', ':.')
  local line_num = vim.fn.line '.'

  -- Find the nearest test line by searching backward
  local current_line = line_num
  local test_pattern = '^%s*test%s+[\'"]'
  local test_line = line_num

  while current_line > 0 do
    local line_content = vim.fn.getline(current_line)
    if line_content:match(test_pattern) then
      test_line = current_line
      break
    end
    current_line = current_line - 1
  end

  local command = 'bundle exec bin/rails test ' .. file_path .. ':' .. test_line
  vim.fn.setreg('+', command)
  print('Copied to clipboard: ' .. command)
end, { desc = 'Copy nearest test line command to clipboard' })

-- Copy the whole current test file command to the clipboard
vim.keymap.set('n', '<leader>cf', function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand '%', ':.')
  local command = 'bundle exec bin/rails test ' .. file_path
  vim.fn.setreg('+', command)
  print('Copied to clipboard: ' .. command)
end, { desc = 'Copy test file command to clipboard' })
