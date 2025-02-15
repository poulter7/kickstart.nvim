-- buffer pick
require('Comment').setup {
  toggler = {
    line = '<Leader>cc',
    block = '<Leader>cb',
  },
  opleader = {
    line = '<Leader>cc',
    block = '<Leader>cb',
  },
}

--- keybindings
local tele = require 'telescope.builtin'
local nx = { 'n', 'x' }
local nv = { 'n', 'v' }

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
require('which-key').add {
  --
  { '<C-h>', require('smart-splits').move_cursor_left },
  { '<C-j>', require('smart-splits').move_cursor_down },
  { '<C-k>', require('smart-splits').move_cursor_up },
  { '<C-l>', require('smart-splits').move_cursor_right },
  { '-', '<Cmd>split<CR>' },
  { '|', '<Cmd>vsplit<CR>' },
  { '<C-w>=', '<Cmd>WindowsEqualize<CR>' },
  { '<C-w>+', '<Cmd>WindowsMaximize<CR>' },
  -- CodeCompanion
  { '<C-a>', '<Cmd>CodeCompanionActions<CR>' },
  { '<Leader>a', '<Cmd>CodeCompanionChat Toggle<CR>' },
  { 'ga', '<Cmd>CodeCompanionChat<CR>' },
  --- toggle term
  { '\\', '<Cmd>execute v:count . "ToggleTerm"<CR>' },
  { '\\', '<Cmd>ToggleTerm<CR>', mode = 't' },
  -- code
  { '<leader>c', group = '[C]ode', mode = nx },
  { '<leader>a', group = '[A]rrow', mode = nx },
  { '<Leader>cv', '<cmd>VenvSelect<cr>' },
  { '<leader>u', group = '[U]ser Interface' },
  { '<leader>ut', '<Cmd>Neotest summary<CR>', desc = 'UI: toggle neotest summary' },
  { '<leader>b', group = '[B]uffers' },
  { '<leader>bp', '<Cmd>BufferPick<CR>', desc = '[B]uffer [P]ick' },
  { '<leader>bx', '<Cmd>BufferPickDelete<CR>', desc = '[B]uffer to [x]' },
  { '<leader>f', group = '[F]ind' },
  { '<leader>fe', '<Cmd>Neotree toggle<CR>', desc = '[F]ind t[E]lescope', silent = true },
  { '<leader>fh', tele.help_tags, desc = '[F]ind [H]elp' },
  { '<leader>fk', tele.keymaps, desc = '[F]ind [K]eymaps' },
  { '<leader>ff', tele.find_files, desc = '[F]ind [F]iles' },
  { '<leader>ft', tele.builtin, desc = '[F]ind a [T]elescope' },
  { '<leader>fw', tele.live_grep, desc = '[F]ind by [\\w]ord (Grep)' },
  { '<leader>fd', tele.diagnostics, desc = '[F]ind [D]iagnostics' },
  {
    '<leader>fo',
    function()
      tele.oldfiles { only_cwd = true }
    end,
    desc = '[F]ind [O]ld files',
  },
  {
    '<leader>fO',
    function()
      tele.oldfiles { only_cwd = false }
    end,
    desc = '[F]ind [O]ld files from everywhere',
  },
  { '<leader>f.', tele.resume, desc = '[F]ind Recent Files ("." for repeat)' },
  {
    '<leader>/',
    function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      tele.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    desc = '[/] Fuzzily search in current buffer',
  },
  -- Open in the current file's parent
  {
    '<leader>f-',
    '<cmd>Yazi<cr>',
    mode = nv,
    desc = '[F]ind using [Y]azi',
  },
  {
    '<leader>f_', -- Open in the current working directory
    '<cmd>Yazi cwd<cr>',
    desc = '[F]ind using [Y]azi in the cwd',
  },
  -- Debug
  { '<leader>d', group = '[D]ebug' },
  { '<leader>dm', '<Cmd>lua require("neotest").run.run { strategy = "dap" }<CR>', desc = '[D]ebug Test [M]ethod' },
  { '<leader>db', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', desc = '[D]ebug: [B]reakpoint' },
  { '<leader>dc', '<Cmd>lua require("dap").continue()<CR>', desc = '[D]ebug: [C]ontinue' },
  { '<leader>dd', '<Cmd>lua require("dap").step_into()<CR>', desc = 'Debug: Step Into' },
  { '<leader>do', '<Cmd>lua require("dap").step_over()<CR>', desc = 'Debug: Step Over' },
  { '<leader>dr', '<Cmd>lua require("dap").step_out()<CR>', desc = 'Debug: Step Out' },
  { '<leader>du', '<Cmd>lua require("dapui").toggle()<CR>', desc = 'Debug: See last session result.' },
  { '<leader>dv', '<Cmd>lua require("dap-view").toggle()<CR>', desc = 'dap-view toggle' },
  { '<leader>ua', '<Cmd>lua _aider_toggle()<CR>', desc = 'ToggleTerm aider' },
  -- Hop
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
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function()
    vim.cmd 'startinsert!'
  end,
}

function _lazygit_toggle()
  lazygit:toggle()
end

--Post-init
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd.colorscheme 'kanagawa'
    -- vim.cmd 'VimadeFocus' -- this breaks ToggleTerm form now
  end,
})

-- set resession to work within a directory
local resession = require 'resession'
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Only load the session if nvim was started with no args and without reading from stdin
    if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
      -- Save these to a different directory, so our manual sessions don't get polluted
      resession.load(vim.fn.getcwd(), { dir = 'dirsession', silence_errors = true })
    end
  end,
  nested = true,
})
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    resession.save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
  end,
})
vim.api.nvim_create_autocmd('StdinReadPre', {
  callback = function()
    -- Store this for later
    vim.g.using_stdin = true
  end,
})

-- Arrow handlers to get buffer -> line -> hop functionality
vim.api.nvim_create_autocmd('User', {
  pattern = 'ArrowOpenFile',
  callback = function(e)
    vim.schedule(function()
      local bfr = vim.api.nvim_get_current_buf()
      local bookmarks = require('arrow.buffer_persist').get_bookmarks_by(bfr)
      if #bookmarks > 0 then
        require('arrow.buffer_ui').openMenu(bfr)
      end
    end)
  end,
})
-- return plugins (this is a polish file, so we don't need to return anything)
return {}
