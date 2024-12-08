return {
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'NLKNguyen/papercolor-theme',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.cmd.colorscheme 'PaperColor'
    end,
    opts = {
      theme = {
        default = {
          allow_italic = 0,
        },
      },
    },
  },

  {
    'projekt0n/github-nvim-theme',
    enabled = false,
  },

  {
    'f-person/auto-dark-mode.nvim',
    dependencies = {},
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
      end,
    },
  },
}
