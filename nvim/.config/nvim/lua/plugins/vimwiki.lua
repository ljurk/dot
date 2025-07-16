return {
    "vimwiki/vimwiki",
    init = function()
        vim.g.vimwiki_ext2syntax = {
            [".Rmd"] = "markdown",
            [".rmd"] = "markdown",
            [".md"] = "markdown",
            [".markdown"] = "markdown",
            [".mdown"] = "markdown",
        }
    end,
}
