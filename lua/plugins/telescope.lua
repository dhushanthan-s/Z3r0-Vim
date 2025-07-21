return {
    {
        "ahmedkhalf/project.nvim", -- https://github.com/ahmedkhalf/project.nvim
        config = function()
            require("project_nvim").setup({
                -- Manual mode doesn't automatically change your root directory, so you have
                -- the option to manually do so using `:ProjectRoot` command.
                manual_mode = false,

                -- Methods of detecting the root directory. **"lsp"** uses the native neovim
                -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
                -- order matters: if one is not detected, the other is used as fallback. You
                -- can also delete or rearangne the detection methods.
                detection_methods = { "lsp", "pattern" },

                -- All the patterns used to detect root dir, when **"pattern"** is in
                -- detection_methods
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

                -- Table of lsp clients to ignore by name
                -- eg: { "efm", ... }
                ignore_lsp = {},

                -- Don't calculate root dir on specific directories
                -- Ex: { "~/.cargo/*", ... }
                exclude_dirs = {},

                -- Show hidden files in telescope
                show_hidden = false,

                -- When set to false, you will get a message when project.nvim changes your
                -- directory.
                silent_chdir = true,

                -- What scope to change the directory, valid options are
                -- * global (default)
                -- * tab
                -- * win
                scope_chdir = 'global',

                -- Path where project.nvim will store the project history for use in
                -- telescope
                datapath = vim.fn.stdpath("data"),
            }) 
        end
    },
    {
        "nvim-telescope/telescope.nvim", -- https://github.com/nvim-telescope/telescope.nvim
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }, -- https://github.com/nvim-lua/plenary.nvim
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search files", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>FF", function ()
                builtin.find_files {
                    hidden = true
                } 
            end, { desc = "Search files with hidden files", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search code", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find Reference", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Find Definition", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Find Implementation", noremap = true, silent = true })
        end
    },
    {
        'nvim-telescope/telescope-media-files.nvim', -- https://github.com/nvim-telescope/telescope-media-files.nvim
        dependencies = { 'nvim-lua/popup.nvim' },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim', -- https://github.com/nvim-telescope/telescope-ui-select.nvim
        config = function ()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    },
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = {"png", "webp", "jpg", "jpeg"},
                        -- find command (defaults to `fd`)
                        find_cmd = "rg"
                    }
                }
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("projects")
            require('telescope').load_extension('media_files')
        end
    },
}
