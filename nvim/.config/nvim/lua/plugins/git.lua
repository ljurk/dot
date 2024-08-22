return {
    {
        "airblade/vim-gitgutter",
        config = function()
            vim.keymap.set("n", "<leader>ga", ":GitGutterStageHunk<Enter>", { desc = "[g]it [a]dd hunk" })
            vim.keymap.set("v", "<leader>ga", ":GitGutterStageHunk<Enter>", { desc = "[g]it [a]dd hunk" })
            vim.keymap.set("n", "<leader>gu", ":GitGutterUndoHunk<Enter>", { desc = "[g]it [u]ndo hunk" })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git<Enter>", {})
            vim.keymap.set("n", "<leader>gc", ":Git commit<Enter>", {})
            vim.keymap.set("n", "<leader>gcn!", ":Git commit --no-edit --amend<Enter>", {})
            vim.keymap.set("n", "<leader>gd", ":Git diff --cached<Enter>", {})
        end,
    },
}
