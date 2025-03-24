-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- terminal mode
vim.api.nvim_set_keymap("t", "<C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
-- clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")
-- remove recording
vim.keymap.set("n", "q", "<Nop>")
-- move focus
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<s-j>", ":bnext<cr>")
vim.keymap.set("n", "<s-k>", ":bprevious<cr>")
vim.keymap.set("n", "<s-d>", ":bdelete<cr>")
-- tab indent multiple times
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- goto declaration & definition
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- editor
vim.o.syntax = 'on'
vim.o.breakindent = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.cursorline = true
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  desc = "Briefly highlight yanked text"
})

-- input
vim.o.updatetime = 200
vim.o.timeoutlen = 300
vim.o.mouse = 'a'

-- window
vim.o.splitbelow = true
vim.o.splitright = true

-- clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- line number
vim.o.number = true
vim.o.relativenumber = true

-- tab
vim.o.expandtab = false
vim.o.tabstop = 8 -- size of '\t'
--vim.o.smarttab = trm.o.expandtab = false
--vim.o.softtabstop = 4
--vim.o.shiftwidth = 4

vim.wo.wrap = false

-- looks and feel
vim.g.have_nerd_font = false

-- diagnostic
vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = false,
}

-- neovide
if vim.g.neovide then
  vim.o.guifont = "Monaspace Krypton:h12"
  vim.g.neovide_padding_top = 5
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_ime = true
  vim.g.neovide_cursor_animation_length = 0.15
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

plugins = {
  -- colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  -- icons
  { 'echasnovski/mini.icons', version = false },
  -- which key
  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>h",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "show keymaps",
      },
    },
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = function()
      local opts = {
        options = {
          icons_enabled = true,
          theme = "auto",
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
      return opts
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = { "echasnovski/mini.icons" },
     config = function()
       vim.opt.termguicolors = true
       require("bufferline").setup{
         options = {
           -- separator_style = "slope",
           indicator = {
             style = 'underline',
           },
         }
       }
     end,
  },
  -- cmp
  {
    "saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = not vim.g.lazyvim_blink_main and "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { "sources.default" }
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'saghen/blink.cmp' },
    lazy = false,
  
    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
        clangd = {},
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')

      require("mason").setup()
      require("mason-lspconfig").setup()

      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  -- fzf
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
      require("fzf-lua").setup()
    end,
    keys = {
	{"<leader>b", mode = { "n" }, function() require"fzf-lua".buffers() end,	desc = "fzf buffers" },	
	{"<leader>k", mode = { "n" }, function() require"fzf-lua".builtin() end,	desc = "fzf buildin commands" },	
	{"<leader>f", mode = { "n" }, function() require"fzf-lua".files() end,		desc = "fzf files" },	
	{"<leader>l", mode = { "n" }, function() require"fzf-lua".live_grep_glob() end,	desc = "fzf grep (live)" },	
	{"<leader>g", mode = { "n" }, function() require"fzf-lua".grep_project() end,	desc = "fzf grep" },	
    },
  },
  -- yazi
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open file manager (Root Dir)",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open file manager (cwd)",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Toggle file manager",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  -- flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  --[[
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    "AndreM222/copilot-lualine",
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      keymap = { preset = 'super-tab' },
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            -- kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
      opts.sections.lualine_x,
      'copilot'
      )
    end,
  },
  ]]
  -- comments
  { 'echasnovski/mini.comment', version = false }, 
  -- align
  { 'echasnovski/mini.align', version = false },
  -- diff
  { 'echasnovski/mini.diff', version = false },
  -- files
  -- { 'echasnovski/mini.files', version = false },
  -- git
  { 'echasnovski/mini-git', version = false, main = 'mini.git' },
  -- scope
  { 'echasnovski/mini.indentscope', version = false },
}

require("lazy").setup({
  spec = {
    plugins,
  },
  install = {
    colorscheme = { "gruvbox" },
  },
  checkver = { enabled = true },
})
