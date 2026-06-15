{ lib, config, ... }:
{

  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {

    programs.nixvim = {
      enable = true;

      globals = {
        loaded_netrw = 1;
        loaded_netrwPlugin = 1;

        latex_view_general_viewer = lib.mkDefault "zathura";

        tex_conceal = "abdmg";
        tex_flavor = "latex";

        mapleader = " ";
        maplocalleader = " ";
      };


      highlight.ExtraWhitespace.bg = "red";

      autoCmd = [
        {
          command = "\"!zathura '%'\" | bdelete";
          event = [
            "BufEnter"
            "BufWinEnter"
          ];
          pattern = [
            "*.pdf"
          ];
        }
      ];


      imports = [
        ./config
      ];

      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
      plugins.web-devicons.enable = true;


      keymaps = [

        # Movements
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
        }

        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
        }

        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
        }

        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
        }

        {
          mode = "t";
          key = "<C-h>";
          action = "<CMD>wincmd h<CR>";
        }

        {
          mode = "t";
          key = "<C-j>";
          action = "<CMD>wincmd j<CR>";
        }

        {
          mode = "t";
          key = "<C-k>";
          action = "<CMD>wincmd k<CR>";
        }

        {
          mode = "t";
          key = "<C-l>";
          action = "<CMD>wincmd l<CR>";
        }

        {
          mode = "n";
          key = "<S-h>";
          action = "<CMD>BufferLineCyclePrev<CR>";
        }        

        {
          mode = "n";
          key = "<S-l>";
          action = "<CMD>BufferLineCycleNext<CR>";
        }        

        # Yazi
        {
          mode = "n";
          key = "<leader>-";
          action = "<CMD>Yazi <CR>";
        }

        # Terminal

        {
          mode = "n";
          key = "<leader>t";
          action = "<CMD>ToggleTerm<CR>";
        }

        {
          mode = "n";
          key = "<leader>gg";
          action = "<CMD>LazyGit<CR>";
        }

      ];
    };

  };
}
