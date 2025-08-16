return {
    "nvim-tree/nvim-tree.lua", -- https://github.com/nvim-tree/nvim-tree.lua
    config = function()
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup({
            vim.keymap.set(
                "n",
                "<leader>e",
                ":NvimTreeToggle <CR>",
                { noremap = true, silent = true, desc = "Toggle File tree" }
            ),
        })
    end,
}
