local conf = "plugins.configs."

local config = function(pluginName)
  return function()
    require(conf .. pluginName)
  end
end

local OBSIDIAN_VAULT = require('constants').OBSIDIAN_VAULT

return {
  {
    "numToStr/Comment.nvim",
    event = { "InsertEnter" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = config("comment"),
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    event = {
      "BufReadPre " .. OBSIDIAN_VAULT .. '/**.md',
      "BufNewFile " .. OBSIDIAN_VAULT .. '/**.md',
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = config("obsidian")
  },

  {
    "Shatur/neovim-ayu",
    config = function()
      vim.cmd.colorscheme("ayu-mirage")
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = config("oil"),
  }

}
