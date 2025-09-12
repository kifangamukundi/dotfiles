return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "folke/lazydev.nvim",
    },

    build = "cargo +nightly build --release",
    -- version = "1.*",

    opts = {
        keymap = {
            preset = "none",
            ["<C-y>"] = { "select_and_accept" },
            ["<C-k>"] = { "select_prev" },
            ["<C-j>"] = { "select_next" },
            ["<C-c>"] = { "cancel" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
            },
        },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = true },
        cmdline = {
            keymap = {
                preset = "inherit",
                ["<C-y>"] = { "select_accept_and_enter" },
            },
            completion = { menu = { auto_show = true } },
        },
    },
    opts_extend = { "sources.default" },
}
