return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  opts = {
    hijack_netrw = false,
    view = {
      width = 40,
    },
    renderer = {
      group_empty = true,
      hidden_display = 'simple',
      icons = {
        git_placement = 'after',
      },
    },
    filters = {
      git_ignored = false,
      custom = { '^.git$' },
    },
    on_attach = function(bufnr)
      local api = require 'nvim-tree.api'

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mappings
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file [E]xplorer', silent = true })
    end,
  },
}
