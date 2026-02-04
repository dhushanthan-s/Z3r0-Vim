return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local ctp = require("catppuccin.palettes").get_palette("mocha")

        local mode_colors = {
            n = ctp.lavender,
            i = ctp.green,
            v = ctp.mauve,
            V = ctp.mauve,
            [""] = ctp.mauve,
            c = ctp.peach,
            r = ctp.red,
            t = ctp.blue,
        }

        local function mode_color()
            return mode_colors[vim.fn.mode()] or ctp.lavender
        end

        require("lualine").setup({
            options = {
                theme = "catppuccin",
                globalstatus = true,
                component_separators = "",
                section_separators = { left = "", right = "" },
            },

            sections = {

                -- LEFT
                lualine_a = {
                    {
                        "mode",
                        color = function()
                            return {
                                fg = ctp.base,
                                bg = mode_color(),
                                gui = "bold",
                            }
                        end,
                        separator = { right = "" },
                        padding = { left = 1, right = 1 },
                    },
                },

                lualine_b = {
                    {
                        "filename",
                        color = { bg = ctp.surface0, fg = ctp.text },
                        separator = { right = "" },
                    },
                },

                -- CENTER
                lualine_c = {
                    {
                        "branch",
                        color = { fg = ctp.green },
                    },
                },

                -- RIGHT
                lualine_w = {
                    {
                        "diff",
                        color = { fg = ctp.text },
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " " },
                    },
                    {
                        "filetype",
                        colored = true,
                    },
                },

                lualine_y = {
                    {
                        "progress",
                        color = { fg = ctp.text },
                    },
                },

                lualine_z = {
                    {
                        "location",
                        color = { fg = ctp.text },
                    },
                },
            },
        })
    end,
}
