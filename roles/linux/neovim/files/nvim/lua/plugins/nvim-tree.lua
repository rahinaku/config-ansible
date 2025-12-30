return {
    "nvim-tree/nvim-tree.lua",
    version      = "*",
    lazy         = false,
    keys         = {
        { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        { "<C-n>",      "<cmd>NvimTreeFocus<cr>",  desc = "Toggle NvimTree" },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config       = function()
        require("nvim-tree").setup {}
    end,
}
