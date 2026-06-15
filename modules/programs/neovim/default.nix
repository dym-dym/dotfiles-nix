{
  config,
  lib,
  pkgs,
  ...
}:

  {
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = let
      # toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLua = str: "\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      # toLuaFile = file: "\n${builtins.readFile file}\nEOF\n";
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
          config = "colorscheme = catppuccin-mocha";
        }

        {
          plugin = dashboard-nvim;
          config = toLuaFile ./nvim/plugin/dashboard.lua;
        }

        # Spinner
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
          plugin = smartcolumn-nvim;
          config = toLua "require(\"smartcolumn\").setup()";
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
          plugin = coq-lsp-nvim;
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

        # Wiki
        vimwiki

      ];

      initLua = ''
        ${builtins.readFile ./nvim/options.lua}
      '';
    };
  };
}
