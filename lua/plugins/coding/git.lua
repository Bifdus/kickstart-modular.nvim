return {
  {
    'akinsho/git-conflict.nvim',
    event = 'BufReadPost',
    version = '*',
    config = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>')
        end,
      })

      require('git-conflict').setup {
        debug = true,
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen', -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        },
      }
    end,
    keys = {
      { '<Leader>gcb', '<cmd>GitConflictChooseBoth<CR>', desc = 'choose both' },
      { '<Leader>gcn', '<cmd>GitConflictNextConflict<CR>', desc = 'move to next conflict' },
      { '<Leader>gcc', '<cmd>GitConflictChooseOurs<CR>', desc = 'choose current' },
      { '<Leader>gcp', '<cmd>GitConflictPrevConflict<CR>', desc = 'move to prev conflict' },
      { '<Leader>gci', '<cmd>GitConflictChooseTheirs<CR>', desc = 'choose incoming' },
    },
  },

  -----------------------------------------------------------------------------
  -- Git UI
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Lazygit' },
    },
  },
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
    keys = {
      { '<Leader>gd', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diff File' },
      { '<Leader>gv', '<cmd>DiffviewOpen<CR>', desc = 'Diff View' },
    },
    config = function()
      require('diffview').setup {
        keymaps = {
          view = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
          file_panel = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
          file_history_panel = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
        },
      }
    end,
  },
}
