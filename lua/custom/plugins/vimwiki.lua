return {
  {
    -- Personal Wiki for Vim
    'vimwiki/vimwiki',
    cmd = { 'VimwikiIndex', 'VimwikiUISelect' },
    keys = {
      { '<Leader>wi', '<cmd>VimwikiIndex<CR>', { noremap = true } },
      { '<Leader>wdi', '<cmd>VimwikiDiaryIndex<CR>', { noremap = true, silent = true } },
      { '<Leader>wdn', '<cmd>VimwikiMakeDiaryNote<CR>', { noremap = true, silent = true } },
    },
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_use_calendar = 1
      vim.g.vimwiki_hl_headers = 1
      vim.g.vimwiki_hl_cb_checked = 1
      vim.g.vimwiki_autowriteall = 0
      vim.g.vimwiki_listsym_rejected = '✗'
      vim.g.vimwiki_listsyms = '○◐●✓'
      vim.g.vimwiki_key_mappings = {
        all_maps = 1,
        global = 1,
        headers = 1,
        text_objs = 1,
        table_format = 1,
        table_mappings = 1,
        lists = 1,
        links = 1,
        html = 1,
        mouse = 0,
      }
      vim.g.vimwiki_list = {
        {
          diary_header = 'Diary',
          diary_link_fmt = '%Y-%m/%d',
          auto_toc = 1,
          path = '~/docs/wiki/',
          syntax = 'markdown',
          ext = '.md',
        },
        {
          path = '~/docs/notes/',
          syntax = 'markdown',
          ext = '.md',
        },
      }
    end,
  },
}
