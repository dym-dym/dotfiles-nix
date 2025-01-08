{lib, config, ...}: {
  options = {
    nvf.enable = lib.mkEnableOption "enable nvf";
  };

  config = lib.mkIf config.nvf.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {

          disableArrows = true;

          statusline.lualine.enable = true;
          telescope = {
            enable = true;
          };

          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;

          filetree.neo-tree.enable = true;

          binds = {
            whichKey = { 
              enable = true;
              setupOpts.preset = "helix";
            };
            cheatsheet.enable = true;
          };

          dashboard.dashboard-nvim.enable = true;

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            enableFormat = true;

            nix = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };

            rust = {
              enable = true;
              treesitter.enable = true;
            };

            ocaml = {
              enable = true;
              treesitter.enable = true;
            };

            haskell = {
              enable = true;
              treesitter.enable = true;
              lsp.enable = true;
            };

            python.enable = true;
            markdown.enable = true;
            lua.enable = true;
          };

          lsp = {
            lightbulb.enable = true;
            lsplines.enable = true;
            nvim-docs-view.enable = true;
            trouble.enable = true;
          };

          notes = { 
            todo-comments.enable = true;
          };

          notify = {
            nvim-notify.enable = true;
          };

          snippets = { 
            luasnip.enable = true;
          };

          spellcheck = {
            enable = true;
            languages = [
              "en"
              "fr"
            ];
          };

          syntaxHighlighting = true;

          tabline = {
            nvimBufferline.enable = true;
          };

          terminal = {
            toggleterm.enable = true;
          };

          theme = {
            enable = true;
            name = "tokyonight";
            style = "night";
          };

          treesitter.indent.enable = true;

          ui = {
            breadcrumbs.navbuddy.enable = true;
            modes-nvim.enable = true;
            noice.enable = true;
            smartcolumn.enable = true;
          };

          utility = {
            motion = {
              leap.enable = true;
            };
          };

          visuals = {
            cinnamon-nvim.enable = true;
            fidget-nvim.enable = true;
            nvim-cursorline.enable = true;
          };
        };
      };
    };
  };
}
