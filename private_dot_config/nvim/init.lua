-- Modern modular Neovim configuration
-- Entry point: bootstraps lazy.nvim, loads core/, then plugins/

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys must be set before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- ============================================================================
-- Core (options, keymaps, autocmds)
-- ============================================================================
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- ============================================================================
-- Plugins (auto-imported from lua/plugins/*.lua)
-- ============================================================================
require("lazy").setup({
  { import = "plugins" },
}, {
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "gruvbox-material" } },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
