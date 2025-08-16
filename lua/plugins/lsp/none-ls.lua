return {
    "nvimtools/none-ls.nvim",
    config = function()
        -- Refer for guide https://github.com/nvimtools/none-ls.nvim
        -- Can help making neovim more like vscode with extensions
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
            },
        })
    end,
}
