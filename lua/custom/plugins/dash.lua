return {
  'mrjones2014/dash.nvim',
  build = 'make install',
  config = function()
    require('dash').setup {}

    vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Dash!<CR>', { noremap = true, silent = true, desc = 'Search Dash for keyword' })
    vim.api.nvim_set_keymap('n', '<leader>dw', '<cmd>DashWord!<CR>', { noremap = true, silent = true, desc = 'Search Dash for word under cursor' })
  end,
}
