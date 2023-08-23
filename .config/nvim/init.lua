-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.syntax = 'on'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- neovide
if vim.g.neovide then
  vim.o.guifont = "Cascadia Mono PL:h12"
  vim.o.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 5
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_input_ime = true
  vim.g.neovide_cursor_animation_length = 0.15
end

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
plugins = {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' }
	}
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
     config = function()
       vim.opt.termguicolors = true
       require("bufferline").setup{
         options = {
           separator_style = "slope",
           indicator = {
             style = 'underline',
           },
         }
       }
     end,
  },
--  {
--    "neoclide/coc.nvim",
--    branch = "release",
--  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  }
}

require("lazy").setup(plugins, opts)
