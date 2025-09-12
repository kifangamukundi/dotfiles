vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        name = "blink.cmp",
        version = 'v1.6.0'
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        require("blink.cmp").setup({
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
                default = { "path", "buffer" },
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
        })
    end,
})
