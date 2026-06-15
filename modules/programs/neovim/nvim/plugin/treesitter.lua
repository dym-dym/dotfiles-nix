
-- local treesitter = require('nvim-treesitter.configs')
local treesitter = require('nvim-treesitter')

treesitter.setup {
	ensure_installed = {},

	ignore_install = { "latex" },
	auto_install = false,

	highlight = { enable = true },

	indent = { enable = true },
}

treesitter.install({ 'rust', 'ocaml', 'html', 'markdown', 'lua' })
