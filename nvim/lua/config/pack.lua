vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  -- git
  "https://github.com/airblade/vim-gitgutter",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-mini/mini.clue",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini-git",
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.sessions",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/benomahony/oil-git.nvim",
  "https://github.com/CRAG666/code_runner.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nickjvandyke/opencode.nvim",
})

require("snacks").setup({ input = { enabled = true } })

vim.g.opencode_opts = {}

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
  require("opencode").ask("@this: ")
end, { desc = "Ask OpenCode" })

vim.keymap.set({ "n", "x" }, "<leader>os", function()
  require("opencode").select()
end, { desc = "Select OpenCode" })

vim.cmd.colorscheme("catppuccin-nvim")

-- conform
require("conform").setup({
  notify_on_error = true,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  formatters = {
    stylua = {
      args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
        "--search-parent-directories",
        "--stdin-filepath",
        "$FILENAME",
        "-",
      },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports-reviser", "gofmt", "golangci-lint" },
    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
    markdown = { "markdownlint-cli2" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    html = { "prettier" },
    cpp = { "clang-format" },
  },
})

-- telescpe
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]iles" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[g]rep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[b]uffers" })
vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "[r]egisters" })
vim.keymap.set("n", "<leader>fe", builtin.diagnostics, { desc = "[e]rrors" })
vim.keymap.set("n", "<leader>fd", function()
  builtin.lsp_document_symbols({ symbols = { "Function", "Method" } })
end, { desc = "[d]efinitions" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[s]tatus" })

vim.keymap.set("n", "<leader>fc", function()
  local current_file_dir = vim.fn.expand("%:p:h:h")
  builtin.find_files({ cwd = current_file_dir })
end, { desc = "[c]urrent directory" })

require("telescope").setup({
  defaults = {
    prompt_prefix = "󰍉 ",
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<A-j>"] = require("telescope.actions").move_selection_next,
        ["<A-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})

-- mini
require("mini.icons").setup()
require("mini.sessions").setup({
  autoread = true,
  autowrite = true,
})
require("mini.surround").setup()
require("mini.git").setup()
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitrebase",
  callback = function(args)
    local preview_win
    vim.keymap.set("n", "<leader>gp", function()
      local action, hash = vim.api.nvim_get_current_line():match("^%s*(%S+)%s+(%x+)")
      local commit_actions = {
        p = true,
        pick = true,
        r = true,
        reword = true,
        e = true,
        edit = true,
        s = true,
        squash = true,
        f = true,
        fixup = true,
        d = true,
        drop = true,
      }
      if not commit_actions[action] or not hash then
        return vim.notify("No commit on this rebase line", vim.log.levels.WARN)
      end

      if preview_win and vim.api.nvim_win_is_valid(preview_win) then
        vim.api.nvim_win_close(preview_win, true)
      end

      local rebase_win = vim.api.nvim_get_current_win()
      vim.cmd("vertical Git show " .. hash)
      local output_win = vim.api.nvim_get_current_win()
      if output_win ~= rebase_win then
        preview_win = output_win
        vim.api.nvim_set_current_win(rebase_win)
      end
    end, { buffer = args.buf, desc = "[p]review commit" })
  end,
})
require("mini.statusline").setup()
-- cursor location to LINE:COLUMN
require("mini.statusline").section_location = function()
  return "%2l:%-2v"
end

local miniclue = require("mini.clue")
require("mini.clue").setup({
  window = {
    delay = 0,
    config = {
      width = "auto",
    },
  },
  triggers = {
    { mode = { "n", "x" }, keys = "<Leader>" },
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "i", keys = "<C-x>" },
    { mode = { "n", "x" }, keys = "g" },
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
    { mode = "n", keys = "<C-w>" },
    { mode = { "n", "x" }, keys = "z" },
    { mode = "n", keys = "m" },
    { mode = "n", keys = "s" },
  },
  clues = {
    { mode = "n", keys = "<leader>h", desc = "+git hunks" },
    { mode = "n", keys = "<leader>g", desc = "+git" },
    { mode = "n", keys = "<leader>f", desc = "+hunks" },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

-- git
vim.keymap.set("n", "<leader>ga", ":GitGutterStageHunk<Enter>", { desc = "[a]dd hunk" })
vim.keymap.set("v", "<leader>ga", ":GitGutterStageHunk<Enter>", { desc = "[a]dd hunk" })
vim.keymap.set("n", "<leader>gu", ":GitGutterUndoHunk<Enter>", { desc = "[u]ndo hunk" })
vim.keymap.set("n", "<leader>gc", ":Git commit<Enter>", { desc = "[c]ommit" })
vim.keymap.set("n", "<leader>gC", ":Git commit --no-edit --amend<Enter>", { desc = "[C]ommit ammend" })
vim.keymap.set("n", "<leader>gd", ":Git diff --cached<Enter>", {})

-- oil
require("oil").setup()
vim.api.nvim_set_keymap(
  "n",
  "<F1>",
  [[<cmd>lua require("oil").toggle_float()<CR>]],
  { noremap = true, silent = true, desc = "Toggle Oil float" }
)
vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
  desc = "Open parent directory",
})
require("oil-git").setup()

-- code-runner
require("code_runner").setup({
  root_markers = {
    { "pyproject.toml", "uv run python $fileName" },
  },
  filetype = {
    python = "uv run python",
  },
})

vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "[r]un", noremap = true, silent = false })
