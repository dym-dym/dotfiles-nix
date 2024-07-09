{ config, pkgs, ... }:

{
  
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';
    

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      # xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      vimPlugins.nvim-lspconfig

      vimPlugins.comment-nvim
      vimPlugins.catppuccin-nvim
    ];
  };

}
