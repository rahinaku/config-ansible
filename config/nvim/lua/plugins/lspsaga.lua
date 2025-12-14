return {
    'nvimdev/lspsaga.nvim',
    version      = "*",
    lazy         = false,
    keys         = {
        { "K",  "<cmd>Lspsaga hover_doc<cr>",             desc = "hover_doc" },
        { "gd", "<cmd>Lspsaga peek_definition<cr>",       desc = "peek_definition" },
        { "ga", "<cmd>Lspsaga code_action<cr>",           desc = "code action" },
        { "gr", "<cmd>Lspsaga rename<cr>",                desc = "rename" },
        { "ge", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "show line diagnostics" },
        { "go", "<cmd>Lspsaga outline<cr>",               desc = "show outline" },
        { "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>",  desc = "diagnostic_jump_next" },
        { "e]", "<cmd>Lspsaga diagnostic_jump_prev<cr>",  desc = "diagnostic_jump_prev" },
    },
    dependencies = {
        "nvim-lspconfig",
    },
    config       = function()
        require("lspsaga").setup({
            lightbulb = {
                enable = true,
                sign = false,
                debounce = 10,
                sign_priority = 40,
                virtual_text = true,
                enable_in_insert = true,
                ignore = {
                    clients = {},
                    ft = {},
                },
            }
        })
    end,
}
