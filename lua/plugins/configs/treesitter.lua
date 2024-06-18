local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  highlight = {
    enable = false,
  },
  indent = { enable = true },
  require("ts_context_commentstring").setup({}), -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})

vim.g.skip_ts_context_commentstring_module = true
