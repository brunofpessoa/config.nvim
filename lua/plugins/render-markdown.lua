return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
        'bullets-vim/bullets.vim'
    },
    opts = {
        heading = {
            icons = { '󰫶 ', '󰫶󰫶 ', '󰫶󰫶󰫶 ', '󰫶󰬃 ', '󰬃 ', '󰬃󰫶 ' },
            position = 'inline',
            border_virtual = true,
        },
        code = {
            language_pad = 2,
            left_pad = 1,
            right_pad = 1,
            border = 'thin',
            above = '', -- important for some color schemes
            below = '', -- important for some color schemes
        },
    },
}
