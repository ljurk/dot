-- Key Mappings

-- Add other key mappings here

-- Filetype-specific Settings
-- Example: Python specific settings
-- autocmd FileType python setlocal foldmethod=indent

-- Spellchecking for Markdown
vim.api.nvim_command("autocmd FileType markdown setlocal spell spelllang=de_de,en_us")

-- Auto Remove Trailing Whitespace and Newlines
vim.api.nvim_command("autocmd BufWritePre * %s/\\s\\+$//e | %s/\\n\\+\\%$//e")
-- Auto Replace tabs with 4 spaces
-- vim.api.nvim_command("autocmd BufWritePre * %s/\t/    /e")

local nnoremap = function(key, action)
    vim.api.nvim_set_keymap("n", key, action, { noremap = true })
end

-- Buffers Navigation
nnoremap("H", ":bnext<Enter>")
nnoremap("L", ":bprevious<Enter>")

-- FZF Integration
nnoremap("<leader>b", ":Buffers<Enter>")
nnoremap("<leader>l", ":Files .<Enter>")
-- move visual block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Misc. Key Mappings
nnoremap("<F2>", ":set list!<Enter>")
nnoremap("<F3>", ":set relativenumber!<Enter>")
nnoremap("<F5>", ":QuickRun<CR>")
nnoremap("<F6>", ":bw! quickrun://output<CR>")
nnoremap("<F7>", ":ALEDetail <ENTER>")
nnoremap("<F8>", ":%normal ]s1z=<ENTER>")
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>Y", '"+Y', { noremap = true })

-- use vims Yank behaviour
nnoremap("Y", "yy")
