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
vim.o.colorcolumn = '80'
-- vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg='Red', bg='Red' })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.vimtex_view_method = 'zathura'
vim.g.latex_view_general_viewer = 'zathura'
vim.g.vimtex_syntax_enabled = 1
vim.o.conceallevel = 0
vim.g.tex_conceal = 'abdmg'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_flavor = 'latex'
vim.g.vimtex_format_enabled = 1
vim.g.vimtex_compiler_latexmk = {
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-shell-escape',
    },
}
vim.g.Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'
-- vim.g.vimtex_compiler_progname = 'nvr'

-- Open zathura on pdf opening --
vim.cmd([[autocmd BufEnter *.pdf execute "!zathura '%'" | bdelete %]])

-- Movements --
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

Map("t", "<C-h>", "<cmd>wincmd h<CR>")
Map("t", "<C-j>", "<cmd>wincmd j<CR>")
Map("t", "<C-k>", "<cmd>wincmd k<CR>")
Map("t", "<C-l>", "<cmd>wincmd l<CR>")

Map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
Map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
Map("n", "<leader>bd", "<cmd>Sayonara<CR>")

-- Windows --
-- Split
Map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc="Split vertically" })
Map("n", "<leader>wh", "<cmd>split<CR>", { desc="Split horizontally" } )

-- Tabs
Map("n", "<leader>wt", "<cmd>tabnew<CR>", { desc="Open new tab" })

-- Neotree --
-- Map("n", "<leader>ee", "<cmd>Neotree left<CR>")
-- Map("n", "<leader>ef", "<cmd>Neotree float<CR>")
-- Map("n", "<leader>e", "<cmd>Neotree float<CR>", { desc = "Open tree explorer" })

-- Telescope --
Map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc="Find files" })
Map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc="Grep in project" })
Map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc="Buffers" })
Map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc="Help Tags" })

-- Lazygit --
Map("n", "<leader>gg", "<cmd>LazyGit <CR>", { desc="Open LazyGit" })

-- Yazi --
Map("n", "<leader>-", "<cmd>Yazi <CR>")
Map("n", "<leader>cw", "<cmd>Yazi cwd<CR>", { desc="Open Yazi in directory" })
Map("n", "<leader>ce", "<cmd>Yazi toggle<CR>", { desc="Toggle Yazi" })

-- ToggleTerm --
Map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc="Open terminal" })
