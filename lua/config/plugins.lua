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
})

