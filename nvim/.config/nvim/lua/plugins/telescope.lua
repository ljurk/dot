return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
        vim.keymap.set("n", "<leader>fc", function()
            local current_file_dir = vim.fn.expand("%:p:h:h")
            builtin.find_files({ cwd = current_file_dir, desc = "[F]ind [F]iles" })
        end, { desc = "[F]ind Files based on [c]urrent directory" })
        require("telescope").setup({
            defaults = {
                prompt_prefix = "󰍉",
                mappings = {
                    i = {
                        -- close telescope by pressing esc only once
                        ["<esc>"] = require("telescope.actions").close,
                        ["<A-j>"] = require("telescope.actions").move_selection_next,
                        ["<A-k>"] = require("telescope.actions").move_selection_previous,
                    },
                },
            },
        })
    end,
}
