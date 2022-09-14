local present = pcall(require, "catppuccin")
if not present then
  return
end

-- vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme jellybeans-nvim]]

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]
