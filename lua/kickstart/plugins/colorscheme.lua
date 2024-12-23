return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.cmd.colorscheme 'github_light_default'
    end,
  },

  { 'vimpostor/vim-lumen' },
}
