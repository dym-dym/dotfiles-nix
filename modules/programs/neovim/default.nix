{ config, lib, pkgs, ... }:

let
  coq-lsp = pkgs.vimUtils.buildVimPlugin {
    name = "coq-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "tomtomjhj";
      repo = "coq-lsp.nvim";
      rev = "e8f8edd56bde52e64f98824d0737127356b8bd4e";
      sha256 = "1lblzp8vdz7lfipbxgvvax4pg7c4x3nm2rlfdfcpf3s55n1g86l4";
    };
  };
in
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {

    programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        nil

        wl-clipboard

        luarocks-nix
        nodejs
        coqPackages.coq-lsp
        coq
      ];

      plugins = with pkgs.vimPlugins; [

        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugin/lsp.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-mocha";
        }

        neodev-nvim

        nvim-cmp
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugin/telescope.lua;
        }

        telescope-fzf-native-nvim
        telescope-zoxide

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets


        {
          plugin = lualine-nvim;
          config = toLuaFile ./nvim/plugin/lualine.lua;
        }

        nvim-web-devicons

        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-ocaml
            p.tree-sitter-rust
          ]));
          config = toLuaFile ./nvim/plugin/treesitter.lua;
        }

        vim-nix

        {
          plugin = dashboard-nvim;
          config = toLuaFile ./nvim/plugin/dashboard.lua;
        }

        {
          plugin = mason-nvim;
          config = toLuaFile ./nvim/plugin/mason.lua;
        }
        mason-lspconfig-nvim
        mason-tool-installer-nvim

        {
          plugin = which-key-nvim;
          config = toLuaFile ./nvim/plugin/which-key.lua;
        }

        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./nvim/plugin/neo-tree-nvim.lua;
        }

        {
          plugin = mini-nvim;
          config = toLuaFile ./nvim/plugin/mini.lua;
        }

        Coqtail
        {
          plugin = coq-lsp;
          config = toLuaFile ./nvim/plugin/coqtail.lua;
        }

        {
          plugin = indent-blankline-nvim;
          config = toLua ''require("ibl").setup()'';
        }

        # {
        #   plugin = coc-nvim;
        #   config = toLuaFile ./nvim/plugin/coc.lua;
        # }
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
      '';
    };
  };
}
