return {
    'goolord/alpha-nvim', -- https://github.com/goolord/alpha-nvim
    config = function ()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')
        dashboard.section.header.val = {

            [[███████╗███████╗██████╗  ██████╗ ██╗   ██╗██╗███╗   ███╗]],
            [[╚══███╔╝██╔════╝██╔══██╗██╔═══██╗██║   ██║██║████╗ ████║]],
            [[  ███╔╝ █████╗  ██████╔╝██║   ██║██║   ██║██║██╔████╔██║]],
            [[ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
            [[███████╗███████╗██║  ██║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
            [[╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],

        }
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        local time = os.date("%H:%M")
        local v = vim.version()
        local version = "v" .. v.major .. "." .. v.minor .. "." .. v.patch
        dashboard.section.footer.val = {
            "     " .. time .. "     ",
            "    " .. version .. "    ",
            " " .. "迷えば, 敗れる" .. " ",
        }
        dashboard.config.opts.noautocmd = true
        alpha.setup(dashboard.config)
    end
}

