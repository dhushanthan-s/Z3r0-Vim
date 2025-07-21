return {
    'smoka7/hop.nvim', -- https://github.com/smoka7/hop.nvim
    version = "v2.7.2",
    config = function()
        -- place this in one of your configuration file(s)
        require('hop').setup {
            keys = 'etovxqpdygfblzhckisuran'
        }
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection

        -- Example
        -- vim.keymap.set('n', 't', function()
        --     hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        -- end, {remap=true})
        -- vim.keymap.set('n', 'T', function()
        --     hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        -- end, {remap=true})

        -- Hop anywhere to {char}
        vim.keymap.set('', '<leader><leader>f', function()
            hop.hint_char1()
        end, { remap=true, desc="Hop to a char" })
        vim.keymap.set('n', '<leader><leader>f', function()
            hop.hint_char1()
        end, { remap=true, desc="Hop to a char" })
        vim.keymap.set('', '<leader><leader>F', function()
            hop.hint_char1({ multi_windows = true })
        end, { remap=true, desc="Hop to a char in any buffer" })
        vim.keymap.set('n', '<leader><leader>F', function()
            hop.hint_char1({ multi_windows = true })
        end, { remap=true, desc="Hop to a char in any buffer" })

        -- Hop to matching 2 chars
        vim.keymap.set('n', 's', function()
            hop.hint_char2()
        end, { remap=true, desc="Hop to 2 matching chars" })

        -- Hop to word
        vim.keymap.set('', '<leader><leader>e', function()
            hop.hint_words()
        end, { remap=true, desc="Hop to any word" })
        vim.keymap.set('n', '<leader><leader>e', function()
            hop.hint_words()
        end, { remap=true, desc="Hop to any word" })
        vim.keymap.set('', '<leader><leader>E', function()
            hop.hint_words({ multi_windows = true })
        end, { remap=true, desc="Hop to any word in any buffer" })
        vim.keymap.set('n', '<leader><leader>E', function()
            hop.hint_words({ multi_windows = true })
        end, { remap=true, desc="Hop to any word in any buffer" })

        -- Hop to line
        vim.keymap.set('', '<leader><leader>l', function()
            hop.hint_lines()
        end, { remap=true, desc="Hop to any line" })
        vim.keymap.set('n', '<leader><leader>l', function()
            hop.hint_lines()
        end, { remap=true, desc="Hop to any line" })

        -- Hop to line skip whitespaces
        vim.keymap.set('', '<leader><leader>L', function()
            hop.hint_lines_skip_whitespace()
        end, { remap=true, desc="Hop to any line skip whitespace" })
        vim.keymap.set('n', '<leader><leader>L', function()
            hop.hint_lines_skip_whitespace()
        end, { remap=true, desc="Hop to any line skip whitespace" })

    end
}
