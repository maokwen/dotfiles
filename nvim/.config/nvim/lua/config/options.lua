-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false

-- neovide
if vim.g.neovide then
  vim.o.guifont = "Monaspace Krypton:h11"
  vim.g.neovide_padding_top = 5
  vim.g.neovide_padding_bottom = 5
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_input_ime = true
  vim.g.neovide_cursor_animation_length = 0.15
end

vim.g.lazyvim_picker = "fzf"
