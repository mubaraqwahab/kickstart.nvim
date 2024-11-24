return {
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'github_light_high_contrast'
    end,
  },

  {
    'f-person/auto-dark-mode.nvim',
    dependencies = {},
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        vim.cmd.colorscheme 'github_dark_dimmed'

        vim.cmd.hi 'Cursor guibg=bg'
        -- Don't italicize
        vim.cmd.hi '@markup.raw cterm=none gui=none'
        vim.cmd.hi '@markup.link.uri cterm=underline gui=underline'
        vim.cmd.hi '@string.special.url cterm=underline gui=underline'
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.cmd.colorscheme 'github_light_high_contrast'

        vim.cmd.hi 'CursorLine guibg=#c0cdd8'
        vim.cmd.hi '@markup.raw cterm=none gui=none'
        vim.cmd.hi '@markup.link.uri cterm=underline gui=underline'
        vim.cmd.hi '@string.special.url cterm=underline gui=underline'
      end,
    },
  },
}
