-- :help options to view all the options
vim.opt.backup = false

-- Set line numbers and relative numbers
-- use `:h vim.opt` to view all the options
vim.opt.number = true
vim.opt.relativenumber = true

-- Setting the position of new tab in split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Using tabspaces instead of space
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Accessing system clipboard through `+` register
vim.opt.clipboard = "unnamedplus"

-- Setting the scroll off so that the cursor stays in the middle of the screen
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8

-- Enables to select empty space after end of line in visual block mode
vim.opt.virtualedit = "block"

-- Splits a window when using substituition `:%s/word/sub`
vim.opt.inccommand = "split"

-- Set the conceal level to 0. allows to see the concealed characters like `*` in markdown
vim.opt.conceallevel = 0

-- code completion menu
vim.opt.completeopt = "menuone,noselect"
vim.opt.pumheight = 10 -- Popup menu height

-- Set file encoding to utf-8
vim.opt.encoding = "utf-8"

-- smart indenting
vim.opt.smartindent = true

-- smart case for search
vim.opt.smartcase = true

-- timeout for keybindings
vim.opt.timeoutlen = 1000

-- set background transparent
-- vim.opt.transparent = true

-- update time
vim.opt.updatetime = 300

-- persistent undo
vim.opt.undofile = true

-- set the backup to false
vim.opt.writebackup = false

-- tab to spaces
vim.opt.expandtab = true

-- highlight current line
vim.opt.cursorline = true

-- wrap lines
vim.opt.wrap = false

-- Ignores case for autocomplete in command `:`
vim.opt.ignorecase = true

-- Uses custom colors or colorscheme
vim.opt.termguicolors = true
vim.opt.winblend = 20

-- Highlight on yank
vim.cmd([[
	autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Visual", timeout=700}
]])

-- ensure virtual_text diags are disabled
vim.diagnostic.config({ virtual_text = false })

-- Neovide options
if vim.g.neovide then
    -- vim.o.guifont = "JetBrainsMono Nerd Font:h14"
    -- Helper function for transparency formatting
    -- local alpha = function()
    --     return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
    -- end
    -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
    -- vim.g.neovide_opacity = 0.0
    vim.g.transparency = 0.8
    -- vim.g.neovide_fullscreen = true
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
    vim.g.neovide_remember_window_size = true
end

-- Enable filetype plugin
vim.cmd([[
    filetype plugin on
]])
