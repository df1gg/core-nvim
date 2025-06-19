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
})

