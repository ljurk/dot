-- Key Mappings

-- Spellchecking for Markdown files (German + English)
vim.api.nvim_command("autocmd FileType markdown setlocal spell spelllang=de_de,en_us")

-- Auto remove trailing whitespace and excess newlines on save
vim.api.nvim_command("autocmd BufWritePre * %s/\\s\\+$//e | %s/\\n\\+\\%$//e")

-- Buffers: H/L to switch buffers (alternative to :bnext/:bprevious)
vim.keymap.set("n", "H", "<cmd>bnext<CR>")
vim.keymap.set("n", "L", "<cmd>bprevious<CR>")

-- Move visual block up/down (keeps selection after moving)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Toggle visibility of special characters (listchars)
vim.keymap.set("n", "<F2>", "<cmd>set list!<CR>")
-- Toggle relative line numbers
vim.keymap.set("n", "<F3>", "<cmd>set relativenumber!<CR>")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("x", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("x", "<leader>Y", '"+Y')

-- Jump between LSP diagnostics
vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)

-- Y yanks whole line (like C/D) instead of from cursor
vim.keymap.set("n", "Y", "yy")