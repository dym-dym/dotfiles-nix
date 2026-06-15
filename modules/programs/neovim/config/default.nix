{ lib, config, ... }:
{
	imports = [
    ./auto-pairs.nix
		./git.nix
		./lazygit.nix
		./options.nix
		./mini.nix
		./blankline.nix
		./treesitter.nix
    ./cmp.nix
    ./which-key.nix
    ./fidget.nix
    ./bufferline.nix
    ./telecope.nix
    ./toggleterm.nix
    ./yazi-nvim.nix
    ./noice.nix
    ./wilder.nix
    ./lsp
    ./lsp/none-ls.nix
    ./lsp/vimtex.nix
	];
}
