local load_textobjects = false
return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function()
          -- disable rtp plugin, as we only need its queries for mini.ai
          -- In case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
          load_textobjects = true
        end,
      },
    },
    cmd = { 'TSUpdateSync' },
    keys = {
      { 'v', desc = 'Increment selection', mode = 'x' },
      { 'V', desc = 'Decrement selection', mode = 'x' },
    },
    ---@type TSConfig
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { 'python' },
      },
      -- ensure_installed = { 'c', 'cpp', 'python', 'rust', 'tsx', 'typescript', 'markdown',
      -- 'markdown_inline' },
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'html',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'vim',
        'vimdoc',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        -- disable for `q:`, when use <CR> as init_selection and node_incremental
        -- disable = function(lang, buf)
        --   if lang == "vim" then
        --     local bufname = vim.api.nvim_buf_get_name(buf)
        --     return string.match(bufname, "%[Command Line%]")
        --   else
        --     return false
        --   end
        -- end,
        keymaps = {
          init_selection = false,
          node_incremental = 'v',
          scope_incremental = false,
          node_decremental = 'V',
          -- init_selection = '<CR>',
          -- node_incremental = '<CR>',
          -- node_decremental = '<BS>',
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)

      if load_textobjects then
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        if opts.textobjects then
          for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require('lazy.core.loader')
              Loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
              local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
              require('lazy.core.loader').source_runtime(plugin.dir, 'plugin')
              break
            end
          end
        end
      end
    end,
  },
}
