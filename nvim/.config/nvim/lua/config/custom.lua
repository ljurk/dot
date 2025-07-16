vim.api.nvim_create_user_command("GitKeepFirstCommit", function()
    local start = vim.fn.search("^# This is the commit message #2:", "n")
    local finish = vim.fn.search("^# Please enter", "n")

    if start > 0 and finish > start then
        vim.cmd(string.format("%d,%dd", start - 1, finish - 1))
    end

    -- Remove remaining comment lines
    vim.cmd([[silent! g/^#.*$/d]])
    vim.cmd([[silent! g/^$/d]])
    vim.cmd([[silent! wq]])
end, {})
