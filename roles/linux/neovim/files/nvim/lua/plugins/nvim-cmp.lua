return
{
    -- 補完エンジン nvim-cmp の設定
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",        -- 挿入モードに入ったときにプラグインをロード
    dependencies = {              -- nvim-cmp に必要な依存プラグイン
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/cmp-buffer" }, -- 現在のバッファの内容を補完候補に含める
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "saadparwaiz1/cmp_luasnip" },     -- LuaSnip と nvim-cmp を統合
        { "L3MON4D3/LuaSnip" },             -- スニペットエンジン LuaSnip
        { "rafamadriz/friendly-snippets" }, -- 事前定義されたスニペットコレクション
    },
    config = function()
        -- nvim-cmp の設定
        local cmp = require("cmp")                         -- nvim-cmp のメインモジュールをロード
        local luasnip = require("luasnip")                 -- LuaSnip のモジュールをロード
        require("luasnip/loaders/from_vscode").lazy_load() -- VSCode スタイルのスニペットをロード

        cmp.setup({
            snippet = {
                -- スニペット展開方法を定義
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- LuaSnip を使ってスニペットを展開
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- 補完候補のドキュメントを上にスクロール
                ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- 補完候補のドキュメントを下にスクロール
                ["<C-Space>"] = cmp.mapping.complete(),            -- 手動で補完候補を表示
                ["<C-e>"] = cmp.mapping.abort(),                   -- 補完を中断して閉じる
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 補完確定 (現在選択中の候補を使用)
            }),
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = "luasnip", priority_weight = 20 }, -- LuaSnip を補完候補に含める
                }, {
                    { name = "buffer" },                        -- バッファの内容を補完候補に含める
                }, {
                    { name = "path" },                          -- ファイルパスを補完候補に含める
                },
                -- {
                --     { name = "copilot", group_index = 2 }
                -- },
                {
                }),
        })
        -- Set up lspconfig.
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
    end,
}
