-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    -- close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function()
    -- Open Neotree on launch. Also remove the line numbers from the Neotree pane
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if vim.fn.isdirectory(vim.fn.expand '%') == 1 then
          vim.cmd 'Neotree toggle'
          vim.opt_local.number = false
          vim.opt.relativenumber = false
        end
      end,
    })
  end,
}
