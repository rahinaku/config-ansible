return {
    'stevearc/overseer.nvim',
    keys = {
        { "<leader>r", "<CMD>OverseerRun<CR>",    desc = "run Oversser" },
        { "<leader>R", "<CMD>OverseerToggle<CR>", desc = "toggle Overseer" },
    },
    opts = {},
    config = function(_, opts)
        require("overseer").setup()
        vim.cmd.cnoreabbrev("OS OverseerShell")
    end
}
