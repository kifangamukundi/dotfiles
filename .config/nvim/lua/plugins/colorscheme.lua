vim.pack.add({
    {
        src = 'https://github.com/rose-pine/neovim',
        name = 'rose-pine',
    },
})

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e6a86", bold = true })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#6e6a86", bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e6a86", bold = true })

    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#393552" })

    vim.api.nvim_set_hl(0, "Visual", { bg = "#44415a" })
    vim.api.nvim_set_hl(0, "Search", { bg = "#31748f", fg = "#e0def4", bold = true })
    vim.api.nvim_set_hl(0, "IncSearch", { bg = "#eb6f92", fg = "#191724", bold = true })
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#9ccfd8", fg = "#191724", bold = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require("rose-pine").setup({
            variant = 'moon',
            styles = {
                transparency = true,
            },
            enable = {
                transparency = true,
            },
        })
        vim.cmd("colorscheme rose-pine")
        ColorMyPencils()
    end,
})
