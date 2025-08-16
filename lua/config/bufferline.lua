local bufferline = require("bufferline")
bufferline.setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                separator = true,
                text_align = "left",
            },
        },
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        modified_icon = "●",
        show_close_icon = false,
        show_buffer_close_icons = false,
    },
})
