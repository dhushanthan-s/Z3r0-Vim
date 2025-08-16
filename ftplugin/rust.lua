local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>a",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end,
    { silent = true, buffer = bufnr }
)
vim.keymap.set(
    "n",
    "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({'hover', 'actions'})
    end,
    { silent = true, buffer = bufnr }
)
vim.g.rustaceanvim = {
    server = {
        cmd = function()
            local mason_registry = require('mason-registry')
            if mason_registry.is_installed('rust-analyzer') then
                -- This may need to be tweaked depending on the operating system.
                local ra = mason_registry.get_package('rust-analyzer')
                local ra_filename = ra:get_receipt():get().links.bin['rust-analyzer']
                return { ('%s/%s'):format(ra:get_install_path(), ra_filename or 'rust-analyzer') }
            else
                -- global installation
                return { 'rust-analyzer' }
            end
        end,
    },
}
