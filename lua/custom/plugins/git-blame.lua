return {
  'f-person/git-blame.nvim',
  config = function()
    require('gitblame').setup {
      display_virtual_text = false,
      date_format = '%b %d, %Y',
      message_template = '<summary> • <date> • <author>',
    }
  end,
  keys = {
    {
      '<leader>gb',
      ':GitBlameOpenCommitURL<CR>',
      desc = 'Git Blame Open Commit URL',
    },
  },
}
