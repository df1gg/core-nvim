-- lua/config/plugins.lua

-- Path to install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If not install — clone
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

-- Add to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Plugins add this
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "c", "javascript", "typescript", "tsx", "html", "css", "json" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",                 -- main autocomplete plugin
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",         -- LSP source
            "hrsh7th/cmp-buffer",           -- bufers
            "hrsh7th/cmp-path",             -- path
            "hrsh7th/cmp-cmdline",          -- :commands
            "L3MON4D3/LuaSnip",             -- snippets engine
            "saadparwaiz1/cmp_luasnip",     -- source for snippets
            "rafamadriz/friendly-snippets"  -- snippets
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Main attach for cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local keymaps = require("config.keymaps")

            -- Python
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = keymaps.on_attach,
            })

            -- C
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = keymaps.on_attach,
            })

            -- JavaScript / TypeScript
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                on_attach = keymaps.on_attach,
            })
        end
    },
})

