-- lua/config/keymaps.lua


vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('n', '<leader>Y', '"+yy', { desc = "Copy line to system clipboard" })

local map = vim.keymap.set

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to below window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to above window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
map('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Terminal: go to left window' })
map('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Terminal: go to below window' })
map('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Terminal: go to above window' })
map('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Terminal: go to right window' })

-- Splits
map('n', '<leader>sh', ':split<CR>',      { desc = 'Horizontal split' })
map('n', '<leader>sv', ':vsplit<CR>',     { desc = 'Vertical split' })
map('n', '<leader>sx', ':close<CR>',      { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=',          { desc = 'Equalize splits' })

map('n', '<leader>c', '<C-w>l', { desc = 'Focus code window' })

-- Open file under cursor in split
map('n', '<leader>sv', ':vsplit <C-R>=expand("<cfile>")<CR><CR>', { desc = 'Open file under cursor in vsplit' })
map('n', '<leader>sh', ':split <C-R>=expand("<cfile>")<CR><CR>', { desc = 'Open file under cursor in split' })

-- Equalize windows
map('n', '<leader>=', '<C-w>=', { desc = 'Equalize window sizes' })

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

