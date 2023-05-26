return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = 'Neotree',
    keys = {
      { "<leader>e", "<cmd>Neotree toggle=true reveal=true position=right<cr>", desc = "NeoTree" },
    },
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup()
    end,
  }
}
