return {
  'zbirenbaum/copilot.lua',
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = false,
      keymap = {
        accept = '<C-k>',
        next = '<C-j>',
      },
    },
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        accept = '<CR>',
        refresh = 'gr',
        open = '<M-CR>',
      },
      layout = {
        position = 'bottom', -- | top | left | right
        ratio = 0.4,
      },
    },
    filetypes = {
      markdown = false,
      help = true,
      text = false,
    },
  },
}
