return {

  { -- Linting
    'mfussenegger/nvim-lint',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {}

      local js_fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
      for _, ft in ipairs(js_fts) do
        lint.linters_by_ft[ft] = { 'eslint_d' }
      end

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      local function element_in(el, table)
        for _, v in ipairs(table) do
          if v == el then
            return true
          end
        end
        return false
      end

      local function eslint_config_available()
        local eslint_config_files = {
          'eslint.config.js',
          'eslint.config.mjs',
          'eslint.config.cjs',
          'eslint.config.ts',
          'eslint.config.mts',
          'eslint.config.cts',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
        }

        for _, config_file in ipairs(eslint_config_files) do
          -- Search the file's dir upwards till the home dir
          local paths_to_search = vim.fn.expand '%:p:h' .. ';' .. vim.fn.expand '~'
          if vim.fn.findfile(config_file, paths_to_search) ~= '' then
            return true
          end
        end

        return false
      end

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function(ev)
          local ft = vim.filetype.match { buf = ev.buf }

          -- Don't lint JS/TS files if there's no eslint config in a parent dir.
          if element_in(ft, js_fts) and not eslint_config_available() then
            return
          end

          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
