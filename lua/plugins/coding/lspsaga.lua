return {
  -----------------------------------------------------------------------------
  -- Lsp Saga
  {
    'nvimdev/lspsaga.nvim',
    event = { 'LspAttach' },
    opts = {
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
      },
      finder = {
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
          jump_to = 'p',
          expand_or_jump = 'o',
          vsplit = 's',
          split = 'i',
          tabe = 't',
          quit = { 'q', '<ESC>' },
        },
      },
      definition = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
      },
      code_action = {
        num_shortcut = true,
        keys = {
          quit = 'q',
          exec = '<CR>',
        },
      },
    },
    config = function(_, opts)
      require('lspsaga').setup(opts)
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
}
