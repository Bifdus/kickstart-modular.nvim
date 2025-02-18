return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    lazy = false,
    cmd = 'Telescope',
    keys = {
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
      { '<leader>st', '<cmd>Telescope builtin<cr>', desc = '[S]earch [S]elect Telescope' },
      { '<leader>scw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
      { '<leader>sR', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
      { '<leader>sr', '<cmd>Telescope lsp_references<cr>', desc = '[S]earch [r]eferences' },
      { '<leader>sI', '<cmd>Telescope lsp_incoming_calls<cr>', desc = '[S]earch [i]ncoming calls' },
      { '<leader>sO', '<cmd>Telescope lsp_outgoing_calls<cr>', desc = '[S]earch [o]utgoing calls' },
      { '<leader>s.', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = '[S]earch existing buffers' },
      { '<leader>ss', '<cmd>Telescope lsp_document_symbols<cr>', desc = '[S]earch [S]ymbols' },
      { '<leader>sj', '<cmd>Telescope jumplist<cr>', desc = '[S]earch [J]umps' },
      { '<leader>su', '<cmd>Telescope undo<cr>', desc = '[S]earch [U]ndo' },
      { '<leader>sj', '<cmd>Telescope jsonfly<cr>', desc = '[s]earch [j]son' },
    },
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
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'jsonfly')
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension 'textcase')

      -- Text Case Mappings
      vim.api.nvim_set_keymap('n', 'gu.', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })
      vim.api.nvim_set_keymap('v', 'gu.', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })

      local builtin = require 'telescope.builtin'

      local function live_grep_with_exclusions()
        -- Prompt for the exclusion patterns
        vim.ui.input({ prompt = 'Exclude patterns (comma-separated, e.g., *.txt,*.log): ' }, function(exclude_patterns)
          local additional_args = {}

          if exclude_patterns and exclude_patterns ~= '' then
            -- Split the exclude_input string by commas and add to additional_args
            for pattern in string.gmatch(exclude_patterns, '([^,]+)') do
              table.insert(additional_args, '--glob')
              table.insert(additional_args, '!' .. pattern)
            end
          end

          -- Execute the live_grep function without a predefined search term
          builtin.live_grep {
            prompt_title = 'Live Grep (Exclusions Applied)',
            additional_args = function()
              return additional_args
            end,
          }
        end)
      end

      vim.keymap.set('n', '<leader>se', live_grep_with_exclusions, { desc = '[S]earch with [E]xclusions' })

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
