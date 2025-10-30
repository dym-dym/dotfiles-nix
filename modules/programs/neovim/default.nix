{
  config,
  lib,
  pkgs,
  ...
}: let
  coq-lsp = pkgs.vimUtils.buildVimPlugin {
    name = "coq-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "tomtomjhj";
      repo = "coq-lsp.nvim";
      rev = "e8f8edd56bde52e64f98824d0737127356b8bd4e";
      sha256 = "1lblzp8vdz7lfipbxgvvax4pg7c4x3nm2rlfdfcpf3s55n1g86l4";
    };
  };
  deadcolumn-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "deadcolumn-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Bekaboo";
      repo = "deadcolumn.nvim";
      rev = "8f5f8610fda22ff7a3937bc72d0e7d41faaceeaa";
      sha256 = "0agxb0kmk0g4z6jxqzyhxs6nhajlrb273grs7slj510zs33pb53x";
    };
  };
in {
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
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
        # coqPackages.coq-lsp
        coq
        python312Packages.pynvim
        texlab
        lazygit
        lean4
      ];

      plugins = with pkgs.vimPlugins; [

        # Theming and looks

        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-mocha";
        }

        {
          plugin = dashboard-nvim;
          config = toLuaFile ./nvim/plugin/dashboard.lua;
        }

        ## Spinner
        {
          plugin = fidget-nvim;
          config = toLuaFile ./nvim/plugin/fidget.lua;
        }

        {
          plugin = noice-nvim;
          config = toLuaFile ./nvim/plugin/noice.lua;
        }

        ## Indentation guides
        {
          plugin = indent-blankline-nvim;
          config = toLuaFile ./nvim/plugin/indent-blank-lines.lua;
        }

        ## Lines
        {
          plugin = lualine-nvim;
          config = toLuaFile ./nvim/plugin/lualine.lua;
        }

        {
          plugin = bufferline-nvim;
          config = toLuaFile ./nvim/plugin/bufferline-nvim.lua;
        }

        ## ColorColumn dynamic change
        {
          plugin = deadcolumn-nvim;
          config = toLuaFile ./nvim/plugin/deadcolumn.lua;
        }
        # Icons
        nvim-web-devicons

        # LSP
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugin/lsp.lua;
        }

        # Syntax Highlighting
        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-ocaml
            p.tree-sitter-rust
          ]);
          config = toLuaFile ./nvim/plugin/treesitter.lua;
        }


        # Snippets and completion
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/cmp.lua;
        }

        cmp_luasnip
        cmp-nvim-lsp

        {
          plugin = cmp-vimtex;
          config = toLuaFile ./nvim/plugin/cmp-vimtex.lua;
        }

        luasnip
        friendly-snippets



        # Comments
        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        # Navigation
        ## Telescope
        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugin/telescope.lua;
        }

        telescope-fzf-native-nvim
        telescope-zoxide

        {
          plugin = which-key-nvim;
          config = toLuaFile ./nvim/plugin/which-key.lua;
        }

        ## Git
        {
          plugin = lazygit-nvim;
          config = toLuaFile ./nvim/plugin/lazygit-nvim.lua;
        }

        ## File explorer
        {
          plugin = yazi-nvim;
          config = toLuaFile ./nvim/plugin/yazi-nvim.lua;
        }

        ## Smooth scrolling
        {
          plugin = neoscroll-nvim;
          config = toLuaFile ./nvim/plugin/neoscroll.lua;
        }

        # Others

        plenary-nvim

        # Languages

        ## Nix
        vim-nix

        ## Coq
        Coqtail
        {
          plugin = coq-lsp;
          # config = toLuaFile ./nvim/plugin/coqtail.lua;
          config = ''
            " Don't load Coqtail
            let g:loaded_coqtail = 1
            let g:coqtail#supported = 0

            " Setup coq-lsp.nvim
            lua require'coq-lsp'.setup()

            function CoqtailHookDefineMappings()
              imap <buffer> <S-Down> <Plug>CoqNext
              imap <buffer> <S-Left> <Plug>CoqToLine
              imap <buffer> <S-Up> <Plug>CoqUndo
              nmap <buffer> <S-Down> <Plug>CoqNext
              nmap <buffer> <S-Left> <Plug>CoqToLine
              nmap <buffer> <S-Up> <Plug>CoqUndo
            endfunction

            if &t_Co > 16
              if &background ==# 'dark'
                hi def CoqtailChecked ctermbg=17 guibg=#113311
                hi def CoqtailSent    ctermbg=60 guibg=#007630
              else
                hi def CoqtailChecked ctermbg=17 guibg=LightGreen
                hi def CoqtailSent    ctermbg=60 guibg=LimeGreen
              endif
            else
              hi def CoqtailChecked ctermbg=4 guibg=LightGreen
              hi def CoqtailSent    ctermbg=7 guibg=LimeGreen
            endif
            hi def link CoqtailError Error
            hi def link CoqtailOmitted coqProofAdmit
          '';
        }

        {
          plugin = lean-nvim;
          config = toLuaFile ./nvim/plugin/lean-nvim.lua;
        }

        ## LaTeX
        {
          plugin = vimtex;
        }

        # Mini
        {
          plugin = mini-nvim;
          config = toLuaFile ./nvim/plugin/mini.lua;
        }

        # Terminal integration
        {
          plugin = toggleterm-nvim;
          config = toLuaFile ./nvim/plugin/toggleterm.lua;
        }

        # Buffers handling
        vim-sayonara

        # {
        #   plugin = mason-nvim;
        #   config = toLuaFile ./nvim/plugin/mason.lua;
        # }
        # mason-lspconfig-nvim
        # mason-tool-installer-nvim


        #
        # {
        #   plugin = neo-tree-nvim;
        #   config = toLuaFile ./nvim/plugin/neo-tree-nvim.lua;
        # }
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
      '';
    };
  };
}
