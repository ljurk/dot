return {
    -- Command and arguments to start the server
    cmd = { "gopls" },

    -- Filetypes to automatically attach to
    filetypes = { "go", "gomod", "gowork", "gotmpl" },

    -- Sets the root directory
    root_markers = { { "go.mod", "go.work" }, ".git" },

    -- gopls-specific settings
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
