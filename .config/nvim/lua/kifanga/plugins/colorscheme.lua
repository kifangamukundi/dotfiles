function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#212121" })

    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#3e8fb0", bold = true })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#f6c177", bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#eb6f92", bold = true })

    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212121" })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3c3c" })

    vim.api.nvim_set_hl(0, "Search", { bg = "#3c3c3c", fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5f5faf", fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#444444", fg = "#ffffff", bold = true })
end

return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            -- 'main', 'moon', or 'dawn'
            variant = "moon",
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
}
