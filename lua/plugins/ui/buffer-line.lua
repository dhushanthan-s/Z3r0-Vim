return {
    "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
    config = function()
        local config = require("bufferline")
        local mocha = require("catppuccin.palettes").get_palette("mocha")
        config.setup({
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                styles = { "italic", "bold" },
                custom = {
                    all = {
                        fill = { bg = "#000000" },
                    },
                    mocha = {
                        background = { fg = mocha.text },
                    },
                    latte = {
                        background = { fg = "#000000" },
                    },
                },
            }),
        })
    end,
}
