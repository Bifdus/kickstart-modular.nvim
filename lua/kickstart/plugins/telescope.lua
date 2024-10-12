return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    -- event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'Myzel394/jsonfly.nvim',
      'debugloop/telescope-undo.nvim',
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-orgmode/telescope-orgmode.nvim',
        -- event = 'VeryLazy',
        after = { 'telescope.nvim', 'orgmode' },
        dependencies = {
          'nvim-orgmode/orgmode',
          'nvim-telescope/telescope.nvim',
        },
        config = function()
          require('telescope').load_extension 'orgmode'

          vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading, { desc = 'Orgmode Refile' })
          vim.keymap.set('n', '<leader>osh', require('telescope').extensions.orgmode.search_headings, { desc = 'Orgmode Search Headings' })
          vim.keymap.set('n', '<leader>oil', require('telescope').extensions.orgmode.insert_link, { desc = 'Orgmode Insert Link' })
        end,
      },
      {
        'johmsalas/text-case.nvim',
        -- lazy = false,
        config = function()
          require('textcase').setup {
            -- Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
            default_keymappings_enabled = true,
            prefix = 'gu',
            substitude_command_name = nil,
            enabled_methods = {
              'to_upper_case',
              'to_lower_case',
              'to_camel_case',
              'to_snake_case',
              -- "to_dash_case",
              'to_title_dash_case',
              'to_constant_case',
              'to_dot_case',
              'to_phrase_case',
              'to_pascal_case',
              'to_title_case',
              'to_path_case',
              'to_upper_phrase_case',
              'to_lower_phrase_case',
            },
          }
        end,
        cmd = { 'TextCaseOpenTelescope', 'Subs' },
        keys = { 'gu' },
      },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          path_display = { 'absolute' },
        },
        pickers = {
          help_tags = {
            mappings = {
              i = {
                ['<CR>'] = function(prompt_bufnr)
                  local selection = require('telescope.actions.state').get_selected_entry()
                  require('telescope.actions').close(prompt_bufnr)
                  vim.cmd('vertical help ' .. selection.value)
                end,
              },
            },
          },
        },
        extensions = {
          undo = {
            mappings = {
              i = {
                ['<cr>'] = require('telescope-undo.actions').restore,
                ['<C-y>'] = require('telescope-undo.actions').yank_deletions,
              },
            },
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          jsonfly = {
            subkeys_display = 'waterfall',
            layout_strategy = 'horizontal',
            layout_config = {
              mirror = false,
              prompt_position = 'top',
              preview_width = 0.4,
            },
          },
          orgmode = {},
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'jsonfly')
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension 'textcase')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>scw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sr', builtin.lsp_references, { desc = '[S]earch [r]eferences' })
      vim.keymap.set('n', '<leader>sI', builtin.lsp_incoming_calls, { desc = '[S]earch [i]ncoming calls' })
      vim.keymap.set('n', '<leader>sO', builtin.lsp_outgoing_calls, { desc = '[S]earch [o]utgoing calls' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing buffers' })
      vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
      vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = '[S]earch [J]umps' })
      vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>')
      vim.keymap.set('n', '<leader>sj', '<cmd>Telescope jsonfly<cr>', { desc = '[s]earch [j]son' })

      vim.api.nvim_set_keymap('n', 'gu.', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })
      vim.api.nvim_set_keymap('v', 'gu.', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          layout_config = {
            width = 0.87,
            height = 0.80,
          },
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
