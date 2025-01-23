-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    opts = {
      ignore = {
        buftype = { 'quickfix', 'nofile' }, -- nofile is for neotest's main buffer
        filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
      },
    },
  },
  {
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = { 'BufEnter' },
    opts = {
      smooth = false,
      hi = {
        fg = '#e98a00',
      },
    },
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup {
        overrides = function() -- add/modify highlights
          return {
            BufferCurrent = { bg = '#e98a00', fg = '#000000' },
            BufferCurrentMod = { link = 'BufferCurrent' },
          }
        end,
      }
    end,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- TODO: not working OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup {
        preset = 'ghost',
        hi = {
          background = 'None',
        },
        options = {
          -- Show the source of the diagnostic.
          show_source = false,
          multilines = {
            enabled = true,
            always_show = false,
          },
          enable_on_insert = true,
        },
      }
    end,
  },
  {
    'smoka7/hop.nvim',
    opts = {},
    keys = {
      {
        'f',
        function()
          require('hop').hint_words { multi_windows = true }
        end,
        mode = { 'n' },
        desc = 'Hop hint words',
      },
      {
        '<S-f>',
        function()
          require('hop').hint_lines { multi_windows = true }
        end,
        mode = { 'n' },
        desc = 'Hop hint lines',
      },
      {
        'f',
        function()
          require('hop').hint_words { extend_visual = true }
        end,
        mode = { 'v' },
        desc = 'Hop hint words',
      },
      {
        '<S-f>',
        function()
          require('hop').hint_lines { extend_visual = true }
        end,
        mode = { 'v' },
        desc = 'Hop hint lines',
      },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = { enabled = true, auto_trigger = true, keymap = { accept = '<C-l>' } },
      panel = { enabled = false },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function(plugin, opts)
      -- TODO: don't exit UI when last session is closed
      -- disable dap events that are created
      -- local dap = require 'dap'
      --
      -- dap.listeners.before.event_terminated['dapui_config'] = nil
      -- dap.listeners.before.event_exited['dapui_config'] = nil
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {
          enabled = false,
        },
        basedpyright = {},
      },
    },
  },
  {
    'tadaa/vimade',
    -- default opts (you can partially set these or configure them however you like)
    opts = {
      fadelevel = 0.7, -- any value between 0 and 1. 0 is hidden and 1 is opaque.
    },
  },
  {
    'akinsho/toggleterm.nvim',
    commit = '193786e0371e3286d3bc9aa0079da1cd41beaa62',
    opts = function(opts)
      opts.direction = 'float'
      return opts
    end,
  },
  {
    'rebelot/heirline.nvim',
    opts = function(_, opts)
      opts.tabline = nil -- remove tabline
    end,
  },
  {
    'jsongerber/thanks.nvim',
    config = true,
  },
  { 'sQVe/sort.nvim' },
  { 'mistweaverco/kulala.nvim', opts = {} },
  {
    '0x00-ketsu/autosave.nvim',
    -- lazy-loading on events
    event = { 'InsertLeave', 'TextChanged' },
    config = function()
      require('autosave').setup {}
    end,
  },
}
