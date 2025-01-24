-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function list_insert_unique(dst, src)
  if not dst then
    dst = {}
  end
  local added = {}
  for _, val in ipairs(dst) do
    added[val] = true
  end
  for _, val in ipairs(src) do
    if not added[val] then
      table.insert(dst, val)
      added[val] = true
    end
  end
  return dst
end

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
      --set colorscheme
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
  {
    'stevearc/resession.nvim',
    opts = {},
  },
  {
    'mrjones2014/smart-splits.nvim',
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      local dap_python = require 'dap-python'
      local adapter_python_path = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python'

      dap_python.setup(adapter_python_path)
    end,
    dependencies = {
      { 'igorlfs/nvim-dap-view', opts = {} },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim', -- use mason-lspconfig to configure LSP installations
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        'lua_ls',
        'basedpyright',
        -- add more arguments for adding more language servers
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim', -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    -- overrides `require("mason-null-ls").setup(...)`
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        'prettier',
        'stylua',
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        'python',
        -- add more arguments for adding more debuggers
      })
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { '<Leader>cv', '<cmd>VenvSelect<cr>' },
    },
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {},
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>f-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = '[F]ind using [Y]azi',
      },
      {
        -- Open in the current working directory
        '<leader>f_',
        '<cmd>Yazi cwd<cr>',
        desc = '[F]ind using [Y]azi in the cwd',
      },

      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}
