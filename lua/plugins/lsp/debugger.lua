return {
    {
        "nvim-neotest/nvim-nio" -- https://github.com/nvim-neotest/nvim-nio
    },
    {

        'mfussenegger/nvim-dap', -- https://github.com/mfussenegger/nvim-dap
        dependencies = {
            "rcarriga/nvim-dap-ui" -- https://github.com/rcarriga/nvim-dap-ui
        },
        config = function ()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({})
            -- DAP windows
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- DAP for C/C++
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
                name = 'lldb'
            }
            -- DAP for Rust 
            dap.adapters.rust = {
                type = "lldb",
                command = "lldb-vscode",
                name = "rust-lldb",
            }
            dap.configurations.rust = {
                {
                    -- ... the previous config goes here ...,
                    initCommands = function()
                        -- Find out where to look for the pretty printer Python module.
                        local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
                        assert(
                        vim.v.shell_error == 0,
                        'failed to get rust sysroot using `rustc --print sysroot`: '
                        .. rustc_sysroot
                        )
                        local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
                        local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                        -- The following is a table/list of lldb commands, which have a syntax
                        -- similar to shell commands.
                        --
                        -- To see which command options are supported, you can run these commands
                        -- in a shell:
                        --
                        --   * lldb --batch -o 'help command script import'
                        --   * lldb --batch -o 'help command source'
                        --
                        -- Commands prefixed with `?` are quiet on success (nothing is written to
                        -- debugger console if the command succeeds).
                        --
                        -- Prefixing a command with `!` enables error checking (if a command
                        -- prefixed with `!` fails, subsequent commands will not be run).
                        --
                        -- NOTE: it is possible to put these commands inside the ~/.lldbinit
                        -- config file instead, which would enable rust types globally for ALL
                        -- lldb sessions (i.e. including those run outside of nvim). However,
                        -- that may lead to conflicts when debugging other languages, as the type
                        -- formatters are merely regex-matched against type names. Also note that
                        -- .lldbinit doesn't support the `!` and `?` prefix shorthands.
                        return {
                            ([[!command script import '%s']]):format(script_file),
                            ([[command source '%s']]):format(commands_file),
                        }
                    end,
                    -- ...,
                },
            }

            vim.keymap.set('n', '<F5>', dap.continue, {})
            vim.keymap.set('n', '<leader>bt', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
            vim.keymap.set('n', '<F6>', dap.continue, { desc = 'Start/Continue' })
            vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Step Over' })
            vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Step Into' })
            vim.keymap.set('n', '<S-F7>', dap.step_out, { desc = 'Step Out' })
            vim.keymap.set('n', '<leader>B', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = 'Debug: Set Breakpoint' })
        end
    }
}
