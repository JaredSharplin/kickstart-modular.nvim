return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      max_lines = 5,
      trim_scope = 'outer',
      mode = 'cursor',
      line_numbers = true,
    }
  end,
}
