-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UI settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex,    { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>w", vim.cmd.write,  { desc = "Write file" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit,   { desc = "Quit a single window" })
vim.keymap.set("n", "<leader>qa", vim.cmd.qall,  { desc = "Quit vim altogether" })
vim.keymap.set("n", "<leader>wv", vim.cmd.split, { desc = "Split window vertically" })
vim.keymap.set("i", "jk", vim.cmd.stopinsert,    { desc = "Switch from INSERT to NORMAL mode" })

