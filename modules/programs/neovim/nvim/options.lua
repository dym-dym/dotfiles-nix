vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.o.clipboard = 'unnamedplus'

-- vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Movements --
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

Map("t", "<C-h>", "<cmd>wincmd h<CR>")
Map("t", "<C-j>", "<cmd>wincmd j<CR>")
Map("t", "<C-k>", "<cmd>wincmd k<CR>")
Map("t", "<C-l>", "<cmd>wincmd l<CR>")

Map("n", "<S-h>", "<cmd>tabprevious<CR>")
Map("n", "<S-l>", "<cmd>tabNext<CR>")

-- Windows --
-- Split 
Map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc="Split vertically" })
Map("n", "<leader>wh", "<cmd>split<CR>", { desc="Split horizontally" } )

-- Tabs 
Map("n", "<leader>wt", "<cmd>tabnew<CR>", { desc="Open new tab" })

-- Neotree --
-- Map("n", "<leader>ee", "<cmd>Neotree left<CR>")
-- Map("n", "<leader>ef", "<cmd>Neotree float<CR>")
Map("n", "<leader>e", "<cmd>Neotree float<CR>", { desc = "Open tree explorer" })

-- Telescope --
Map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
Map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
Map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
Map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

