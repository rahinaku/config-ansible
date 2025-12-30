return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({})
    end,
    enabled = false
}
