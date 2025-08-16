return {
    {
        "rebelot/kanagawa.nvim", -- https://github.com/rebelot/kanagawa.nvim
        enabled = false,
        config = function()
            require("kanagawa").setup({
                transparent = true,
            })
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- https://github.com/catppuccin/nvim
        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
                transparent_background = true,
                integrations = {
                    cmp = true,
                    nvimtree = true,
                    treesitter = true,
                    telescope = {
                        enabled = true,
                    },
                    alpha = true,
                    mason = false,
                    dap = true,
                    dap_ui = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    which_key = false,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
