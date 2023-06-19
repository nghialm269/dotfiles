return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  keys = {
    {
      mode = { "i", "s" },
      "<C-e>",
      function()
        if require("luasnip").choice_active() then
          require("luasnip.extras.select_choice")()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<C-e>]], true, true, true), 'n', true)
        end
      end,
      desc = "Snippets: Select Choices"
    }
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    update_events = "TextChanged,TextChangedI",
    store_selection_keys = "<C-s>",
    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { " ", "TSTextReference" } },
        },
      },
      [require("luasnip.util.types").insertNode] = {
        active = {
          virt_text = { { " ", "TSEmphasis" } },
        },
      },
    },
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)
    ls.add_snippets("go", require("plugins.snippets.go"))
  end,
}
