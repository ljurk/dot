return {
    {
        "airblade/vim-gitgutter",
        config = function()
            vim.keymap.set("n", "<leader>ga", ":GitGutterStageHunk<Enter>", {})
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>ga", ":GitGutterStageHunk<Enter>", {})
            vim.keymap.set("n", "<leader>gs", ":Git<Enter>", {})
            vim.keymap.set("n", "<leader>gc", ":Git commit<Enter>", {})
            vim.keymap.set("n", "<leader>gcn!", ":Git commit --no-edit --amend<Enter>", {})
            vim.keymap.set("n", "<leader>gd", ":Git diff --cached<Enter>", {})
        end,
    },
}
