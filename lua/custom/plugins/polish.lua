-- keybindings
local wk = require 'which-key'
--- nav
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '-', '<Cmd>split<CR>')
vim.keymap.set('n', '|', '<Cmd>vsplit<CR>')
vim.keymap.set('n', '<C-w>=', '<Cmd>WindowsEqualize<CR>')
vim.keymap.set('n', '<C-w>+', '<Cmd>WindowsMaximize<CR>')

--- toggle term
vim.keymap.set('n', '\\', '<Cmd>execute v:count . "ToggleTerm"<CR>')
vim.keymap.set('t', '\\', '<Cmd>ToggleTerm<CR>')

--- buffer pick
wk.add {
  { '<leader>b', group = '[B]uffers' },
}
vim.keymap.set('n', '<Leader>bb', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<Leader>bD', '<Cmd>BufferPickDelete<CR>')

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
  on_close = function(term)
    vim.cmd 'startinsert!'
  end,
}

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

wk.add {
  { '<leader>d', group = '[D]ebug' },
  { '<leader>dm', '<Cmd>lua require("neotest").run.run { strategy = "dap" }<CR>', desc = 'Debug Test' },
  { '<leader>db', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', desc = 'Debug: Toggle Breakpoint' },
  { '<leader>dc', '<Cmd>lua require("dap").continue()<CR>', desc = 'Debug: Start/Continue' },
  { '<leader>dd', '<Cmd>lua require("dap").step_into()<CR>', desc = 'Debug: Step Into' },
  { '<leader>do', '<Cmd>lua require("dap").step_over()<CR>', desc = 'Debug: Step Over' },
  { '<leader>dr', '<Cmd>lua require("dap").step_out()<CR>', desc = 'Debug: Step Out' },
  { '<leader>du', '<Cmd>lua require("dapui").toggle()<CR>', desc = 'Debug: See last session result.' },
  { '<leader>dv', '<Cmd>lua require("dap-view").toggle()<CR>', desc = 'dap-view toggle' },
  { '<leader>g', '<Cmd>lua _lazygit_toggle()<CR>', desc = 'ToggleTerm lazygit' },
}

-- set colorscheme
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd.colorscheme 'kanagawa'
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

-- return plugins (this is a polish file, so we don't need to return anything)
return {}
