-- lua/config/keymaps.lua


vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('n', '<leader>Y', '"+yy', { desc = "Copy line to system clipboard" })

-- Function to set the keys when the LSP is started in the buffer
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- 📍 Go to definition
    nmap("gd", vim.lsp.buf.definition, "Go to Definition")

    -- 📚 Hover-document on cursor
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

    -- 🧠 Rename symbol
    nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")

    -- 💡 Show actions (imports, fix...)
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

    -- 🔍 Show all use symbol
    nmap("gr", vim.lsp.buf.references, "References")

    -- 🧭 Go to declaration
    nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")

    -- 🚀 Formating
    nmap("<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, "Format File")
end

-- Making the function available from other files
return {
    on_attach = on_attach,
}

