return {
    "kdheepak/lazygit.nvim", -- https://github.com/kdheepak/lazygit.nvim
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
    },
}
