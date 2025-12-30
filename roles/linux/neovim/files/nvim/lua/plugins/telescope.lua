return {
    'nvim-telescope/telescope.nvim',
    tag          = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    keys         = {
        {
            "<leader>tf",
            function()
                require('telescope.builtin').find_files()
            end,
            desc = "Telescope Find"
        },
        {
            "<leader>tg",
            function()
                require('telescope.builtin').live_grep()
            end,
            desc = "Telescope Grep"
        },
        {
            "<leader>tb",
            function()
                require('telescope.builtin').buffers()
            end,
            desc = "Telescope Buffer"
        },
        {
            "<leader>th",
            function()
                require('telescope.builtin').help_tags()
            end,
            desc = "Telescope help tags"
        },
        {
            "<leader>tr",
            function()
                require('telescope.builtin').lsp_references();
            end,
            desc = "Telescope lsg_references"
        },
        {
            "<leader>td",
            function()
                require('telescope.builtin').lsp_definitions();
            end,
            desc = "Telescope lsg_definitions"
        },
    },
}
