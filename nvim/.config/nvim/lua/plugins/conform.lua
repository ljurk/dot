return { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
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
                    "4",
                    "--search-parent-directories",
                    "--stdin-filepath",
                    "$FILENAME",
                    "-",
                },
            },
        },

        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt", "goimports-reviser", "golangci-lint" },
            python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            html = { "prettier" },
            cpp = { "clang-format" },
        },
    },
}
