return {
    "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
    config = function()
        require("bufferline").setup({})
    end,
}
