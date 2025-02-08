return {
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          alt = { 'FIX', 'BUG', 'ISSUE' },
        },
        WARN = { alt = { 'WARNING' } },
        PERF = { alt = { 'OPT', 'OPTIMIZE' } },
      },
      highlight = {
        before = '',
        keyword = 'wide',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
    },
  },
}
