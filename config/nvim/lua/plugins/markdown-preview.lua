return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
        if vim.fn.executable "npx" then
            vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install && npm install")
        else
            vim.cmd [[Lazy load markdown-preview.nvim]]
            vim.fn["mkdp#util#install"]()
        end
    end,
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
        vim.g.mkdp_auto_start = 1
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_combine_preview = 1
    end
}
